defmodule Hello.Message do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:text, :id]}
  schema "messages" do
    field :text, :string
    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:text])
    |> validate_required([:text])
  end
end
