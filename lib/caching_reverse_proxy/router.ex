defmodule CachingReverseProxy.Router do
  use Plug.Router
  import Plug.Conn

  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json, Absinthe.Plug.Parser],
    pass: ["*/*"],
    json_decoder: Jason
  )

  plug(:match)
  plug(:dispatch)

  forward("/graphql",
    to: Absinthe.Plug.GraphiQL,
    init_opts: [schema: CachingReverseProxy.Schema]
  )

  match _ do
    IO.puts("Got here")
    send_resp(conn, 404, "Oops!")
  end
end
