# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands
- Build: `mix compile`
- Test: `mix test`
- Run a single test: `mix test path/to/test_file.exs:line_number`
- Format: `mix format`

## Code Style Guidelines
- Follow standard Elixir style conventions
- Use `embedded_schema` for OpenRTB data structures
- Define relationships with `embeds_one` and `embeds_many`
- Use proper type specifications on all functions
- Handle errors gracefully with pattern matching
- Organize code by OpenRTB version and entity type (v2, v3)
- Follow JSON encoding/decoding patterns established in json/encoder.ex
- Use custom types (like TinyInt) consistently
- Maintain test coverage with JSON examples in test/data/
- Write tests that validate both valid and invalid structures
- Names should match OpenRTB specification terminology exactly