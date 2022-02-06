defmodule Store.Maker do
  use Ecto.Schema
  import Ecto.Changeset

  @fields [:name, :country, :itn]

  schema "makers" do
    field :name, :string, size: 64
    field :country, :string, size: 64
    field :itn, :string, size: 10
    has_many :product, Store.Product
    many_to_many :clients, Store.Client, join_through: "orders"
    timestamps()
  end

  def changeset(%__MODULE__{} = maker, attrs) do
    maker
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> validate_length(:itn, min: 8, max: 10)
  end
end
