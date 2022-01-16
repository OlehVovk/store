defmodule Store.Clients do
  alias Store.Client
  alias Store.Repo

  def create(%{} = params) do
    Client.changeset(%Client{}, params)
    |> Repo.insert()
  end

  def update(%{"id" => id} = params) do
    with %Client{} = client <- Repo.get(Client, id) do
      Client.changeset(client, params)
      |> Repo.update()
    end
  end

  def delete(%{"id" => id}) do
    with %Client{} = client <- Repo.get(Client, id) do
      Repo.delete(client)
    end
  end

  def get(%{"id" => id}) do
    Repo.get(Client, id)
  end

  def index(_params) do
    Client
    # TODO implement filters 1) name 2) phone 3) year birhtday  4) gender 
    |> Repo.all()
  end
end
