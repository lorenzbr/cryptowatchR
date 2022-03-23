# cryptowatchR 0.2.0.9000 (dev)

* Minor style formatting and performance improvements
* Add tests for several functions

# cryptowatchR 0.2.0

* Now `get_markets()` works with all routes (`summary`, `summaries`, `price`, `prices`, `trades` and `orderbook`, `orderbook/liquidity` and `orderbook/calculator`).
* New functions which are wrappers around `get_markets()`: `get_ohlc()`, `get_trades()`, `get_current_prices()`, `get_summary()`, `get_orderbook()`, `get_orderbook_liquidity()` and `get_orderbook_calculator()`
* New feature to use your own API key for all functions. See argument `api_key` in functions.
* New feature to show allowance (costs per request, remaining credits). See argument `allowance` in functions.
* `markets()` is now deprecated and will be removed in a future version. Use `get_ohlc()` instead.

# cryptowatchR 0.1.0

* First release published on CRAN
