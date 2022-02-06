defmodule Store.OrdersInBasket do
  alias Store.OrderInBasket
  alias Store.Repo

  def create(%{} = params) do
    OrderInBasket.changeset(%OrderInBasket{}, params)
    |> Repo.insert()
  end

  def update(%{"id" => id} = params) do
    with %OrderInBasket{} = order_in_basket <- Repo.get(OrderInBasket, id) do
      OrderInBasket.changeset(order_in_basket, params)
      |> Repo.update()
    end
  end

  def delete(%{"id" => id}) do
    with %OrderInBasket{} = order_in_basket <- Repo.get(OrderInBasket, id) do
      Repo.delete(order_in_basket)
    end
  end

  def get(%{"id" => id}) do
    Repo.get(OrderInBasket, id)
  end

  def index(_params) do
    OrderInBasket
    |> Repo.all()
  end
end
