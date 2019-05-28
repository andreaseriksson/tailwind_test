defmodule TailwindTest.Repo do
  use Ecto.Repo,
    otp_app: :tailwind_test,
    adapter: Ecto.Adapters.Postgres
end
