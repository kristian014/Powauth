# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Powauthproject.Repo.insert!(%Powauthproject.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Powauthproject.Videos
for category <- ~w(Action Drama Romanace Comedy Sci-fi Programming Tv-Series) do
  Videos.create_category!(category)
end
