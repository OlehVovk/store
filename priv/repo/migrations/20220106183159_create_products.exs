defmodule Store.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table("makers") do
      add :name, :string, size: 64
      add :country, :string, size: 64

      timestamps()
    end

    create table("clients") do
      add :name, :string, size: 64
      add :city, :string, size: 24
      add :gender, :string, size: 1
      add :birthday, :date
      add :phone, :string, size: 16
      add :discount, :integer

      timestamps()
    end

    create table("orders") do
      add :client_id, references("clients", on_delete: :restrict, on_update: :update_all)
      add :orderdata, :date
      add :donedata, :date
      add :shiptype, :string, size: 24
      add :shipcity, :string, size: 24
      add :shipcost, :decimal

      timestamps()
    end

    create table("products") do
      add :maker_id, references("makers", on_delete: :restrict, on_update: :update_all)
      add :name, :string, size: 32
      add :price, :decimal

      timestamps()
    end

    create table("order_basket") do
      add :order_id, references("orders", on_delete: :delete_all, on_update: :update_all)
      add :product_id, references("products", on_delete: :delete_all, on_update: :update_all)
      add :quantity, :integer
      add :discount, :integer

      timestamps()
    end

    create index("products", [:name])
    create index("products", [:maker_id])
    create index("order_basket", [:order_id])
    create index("order_basket", [:product_id])
    create index("makers", [:name])
    create index("orders", [:client_id])
  end
end
