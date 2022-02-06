defmodule Store.Products do
  alias Store.Product
  alias Store.Repo
  import Ecto.Query

  def create(%{} = params) do
    Product.changeset(%Product{}, params)
    |> Repo.insert()
  end

  def update(%{"id" => id} = params) do
    with %Product{} = product <- Repo.get(Product, id) do
      Product.changeset(product, params)
      |> Repo.update()
    end
  end

  def delete(%{"id" => id}) do
    with %Product{} = product <- Repo.get(Product, id) do
      Repo.delete(product)
    end
  end

  def get(%{"id" => id}) do
    Repo.get(Product, id)
  end

  def index(params) do
    conditions = Enum.reduce(params, true, fn
      {"maker_id", maker_id}, conditions ->
        dynamic([p], p.maker_id == ^maker_id and ^conditions)

      {"name", name}, conditions ->
        dynamic([p], p.name == ^name and ^conditions)

      {"price", price}, conditions ->
        dynamic([p], p.price == ^price and ^conditions)
    end)




    #
    # maker_id = params["maker_id"]
    # name = params["name"]
    # price = params["price"]
    #
    # conditions =
    #   if maker_id do
    #     dynamic([p], p.maker_id == ^maker_id)
    #   else
    #     true
    #   end
    #
    # conditions =
    #   if name do
    #     dynamic([p], p.name == ^name and ^conditions)
    #   else
    #     conditions
    #   end
    #
    # conditions =
    #   if price do
    #     dynamic([p], p.price == ^price and ^conditions)
    #   else
    #     conditions
    #   end
    #


    Product
    |> where(^conditions)
    |> Repo.all()
  end

  def price_information(params) do
    Enum.reduce(params, Product,  fn
      {"maker_ids", maker_ids}, query ->
      query |> where([p], p.maker_id in ^maker_ids)
      {"name", name}, query ->
      query |> where([p], ilike(p.name, ^"%#{name}%"))
      _, query -> query
    end)

    |> select([p], %{min: min(p.price), max: max(p.price), avg: avg(p.price)})
    |> Repo.one()
  end
end
