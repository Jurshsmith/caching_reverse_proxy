defmodule CachingReverseProxy.NPM.Driver do
  @one_graph_app_url "https://serve.onegraph.com/graphql?app_id=0b33e830-7cde-4b90-ad7e-2a39c57c0e11"

  @spec fetch_npm_package_description(binary) :: {:ok, %{description: term}}
  def fetch_npm_package_description(name) when is_binary(name) do
    try do
      Neuron.Config.set(url: @one_graph_app_url)

      case Neuron.query(
             """
               query getNPMPackageDescription($name: String!){
                 npm {
                   package(name: $name) {
                     description
                   }
                 }
               }
             """,
             %{name: name}
           ) do
        {:ok, %{body: %{"data" => %{"npm" => %{"package" => %{"description" => description}}}}}} ->
          {:ok, %{description: description}}

        _ ->
          {:ok, %{description: nil}}
      end
    rescue
      _ -> {:ok, %{description: nil}}
    end
  end
end
