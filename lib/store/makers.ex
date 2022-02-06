defmodule Store.Makers do
  alias Store.Maker
  alias Store.Repo
  alias Store.Product
  import Ecto.Query

  def create(%{} = params) do
    Maker.changeset(%Maker{}, params)
    |> Repo.insert()
  end

  def update(%{"id" => id} = params) do
    with %Maker{} = maker <- Repo.get(Maker, id) do
      Maker.changeset(maker, params)
      |> Repo.update()
    end
  end

  def delete(%{"id" => id}) do
    with %Maker{} = maker <- Repo.get(Maker, id) do
      Repo.delete(maker)
    end
  end

  def get(%{"id" => id}) do
    Repo.get(Maker, id)
  end

  def index(_params) do
    Maker
    |> Repo.all()
  end

  def active_makers() do
    from(m in Maker, join: p in Product, on: m.id == p.maker_id, group_by: m.id, select: %{maker_id: m.id, count: count(m.id)})
    |> Repo.all()
  end

end
