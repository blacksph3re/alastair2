use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or you later on).
config :alastair, Alastair.Endpoint,
  secret_key_base: "zGmqED/HnFdY+KYKtqCXfoHYMvpJHJ7Hprv09yiJzT6dFt/dneHg7fwqqBUdRU+d"

# Configure your database
config :alastair, Alastair.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "alastair_prod",
  hostname: System.get_env("DB_HOST") || "localhost",
  pool_size: 20
