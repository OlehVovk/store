defmodule Store.Order_in_basket do
  use Ecto.Schema

  schema "order_basket" do
    belongs_to :order, Store.Order
    belongs_to :product, Store.Product
    field :quantity, :integer
    field :discount, :integer

    timestamps()
  end
end
