FROM bitwalker/alpine-elixir-phoenix:latest

RUN mkdir /api_auth
WORKDIR /api_auth
COPY . /api_auth

RUN mix deps.get
RUN mix compile
# RUN mix ecto.reset

EXPOSE 4000
# CMD ["mix","phx.server"]
CMD ["mix","ecto.reset"]