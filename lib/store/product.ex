defmodule Store.Product do
  use Ecto.Schema

  schema "products" do
    belongs_to :maker, Store.Maker
    field :name, :string, size: 32
    field :price, :decimal
    timestamps()
  end
end
