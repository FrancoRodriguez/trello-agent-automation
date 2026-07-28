# frozen_string_literal: true

require "net/http"
require "uri"
require "json"

class TrelloClient
  BASE_URL = "https://api.trello.com/1"

  attr_reader :api_key, :token, :board_id

  def initialize(api_key: ENV["TRELLO_API_KEY"], token: ENV["TRELLO_TOKEN"], board_id: ENV["TRELLO_BOARD_ID"])
    @api_key = api_key
    @token = token
    @board_id = board_id

    raise ArgumentError, "TRELLO_API_KEY and TRELLO_TOKEN must be configured in environment" if @api_key.nil? || @token.nil?
  end

  def lists
    endpoint = "#{BASE_URL}/boards/#{@board_id}/lists?#{auth_params}"
    response = get_json(endpoint)
    response.each_with_object({}) do |list, hash|
      hash[list["name"]] = list["id"]
      hash[list["name"].downcase] = list["id"]
    end
  end

  def find_list_id(list_name)
    all_lists = lists
    all_lists[list_name] || all_lists[list_name.downcase]
  end

  def cards_in_list(list_name_or_id)
    list_id = lists[list_name_or_id] || list_name_or_id
    raise "List '#{list_name_or_id}' not found on board #{@board_id}" unless list_id

    endpoint = "#{BASE_URL}/lists/#{list_id}/cards?#{auth_params}"
    get_json(endpoint)
  end

  def get_card(card_id)
    endpoint = "#{BASE_URL}/cards/#{card_id}?#{auth_params}"
    get_json(endpoint)
  end

  def move_card(card_id, target_list_name)
    list_id = find_list_id(target_list_name)
    raise "Target list '#{target_list_name}' not found on board #{@board_id}" unless list_id

    uri = URI("#{BASE_URL}/cards/#{card_id}?#{auth_params}&idList=#{list_id}")
    req = Net::HTTP::Put.new(uri)

    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      http.request(req)
    end

    JSON.parse(res.body)
  end

  def add_comment(card_id, text)
    uri = URI("#{BASE_URL}/cards/#{card_id}/actions/comments?#{auth_params}")
    req = Net::HTTP::Post.new(uri)
    req.set_form_data("text" => text)

    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      http.request(req)
    end

    JSON.parse(res.body)
  end

  def get_card_comments(card_id)
    endpoint = "#{BASE_URL}/cards/#{card_id}/actions?filter=commentCard&#{auth_params}"
    actions = get_json(endpoint) rescue []
    actions.map do |action|
      {
        author: action.dig("memberCreator", "fullName") || action.dig("memberCreator", "username"),
        text: action.dig("data", "text"),
        date: action["date"]
      }
    end
  end

  private

  def auth_params
    "key=#{@api_key}&token=#{@token}"
  end

  def get_json(url_string)
    uri = URI(url_string)
    res = Net::HTTP.get_response(uri)
    unless res.is_a?(Net::HTTPSuccess)
      raise "Trello API error [#{res.code}]: #{res.body}"
    end
    JSON.parse(res.body)
  end
end
