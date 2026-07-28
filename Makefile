# Makefile for Trello Agent Automation Framework

.PHONY: trello trello-check test clean

# Run continuous Trello watcher daemon (polls every 30s)
trello:
	bin/trello_agent_runner --poll 30

# Check Trello integration connectivity and view pending cards
trello-check:
	bin/trello_agent_runner --check

# Test runner script
test:
	ruby -Ilib -r dotenv/load -r trello_client -e 'puts "TrelloClient syntax OK"'

clean:
	rm -rf tmp log .antigravitycli
