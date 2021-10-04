# CachingReverseProxy

This is a reverse proxy that knows a given request destination based on a predefined GraphQl request schema. It will map to the corresponding destination server and cache responses to speed up request response cycle.

- If old request, serve cached data.
- If new request, makes a call to the actual endpoint to get the data and cache it
- If request comes after the cache is invalid, make a call to the endpoint to update the cache, but if the call fails, return stale invalidated data.

## How To Run The Application

Base Software Dependencies: `Erlang` and `Elixir`

Clone the repo:

`git clone https://github.com/Jurshsmith/caching_reverse_proxy.git`

Enter the root directory:

`cd caching_reverse_proxy`

Install dependencies:

`mix deps.get`

Run in Interactive Session:

`iex -S mix run --no-halt`

Or Run using `mix run --no-halt`

Then, visit your localhost: `http://localhost:4040/graohql`

Right now the only valid graphql query is to get `npm` package description.

A sample valid graphql request is:

```
query SimpleGetNpmPackageDescription{
 npmPackage(name: "react") {
      description
    }
}
```

Notice the response cycle decreases on more requests.

To adjust cache expiration period time. Edit the `config.exs` file and update the `expiration_period` for `:caching_reverse_proxy` config.

Update the cache strategy supported types:

`:custom_cache` or `:ets_cache`

#### Run tests

`mix test`

### Things that can be improved

- Partitioning the cache for parallelization (with some probability based on some consistent hash algo)

- Doctests

- Integration tests
