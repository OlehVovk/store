defmodule Store.Order do
    use Ecto.Schema
    import Ecto.Changeset

@fields [ :client_id, :orderdata, :donedata, :shiptype, :shipcity, :shipcost ]

    schema "orders" do
      belongs_to :client, Store.Client
      field :orderdata, :date
      field :donedata, :date
      field :shiptype, :string, size: 24
      field :shipcity, :string, size: 24
      field :shipcost, :decimal
      timestamps()
    end
    def changeset(%__MODULE__{} = order, attrs) do
      order
      |> cast(attrs, @fields)
    end
  end
