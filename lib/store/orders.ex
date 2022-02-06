defmodule Store.Orders do
  alias Store.Order
  alias Store.Repo

  def create(%{} = params) do
    Order.changeset(%Order{}, params)
    |> Repo.insert()
  end

  def update(%{"id" => id} = params) do
    with %Order{} = order <- Repo.get(Order, id) do
      Order.changeset(order, params)
      |> Repo.update()
    end
  end

  def delete(%{"id" => id}) do
    with %Order{} = order <- Repo.get(Order, id) do
      Repo.delete(order)
    end
  end

  def get(%{"id" => id}) do
    Repo.get(Order, id)
  end

  def index(_params) do
    Order
    |> Repo.all()
  end
end
