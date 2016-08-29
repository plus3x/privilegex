ERLANG_PATH = $(shell erl -eval 'io:format("~s", [lists:concat([code:root_dir(), "/erts-", erlang:system_info(version), "/include"])])' -s init stop -noshell)

all: priv/setuid.so

NIF_SRC=\
	src/setuid.c

priv/setuid.so: $(NIF_SRC)
	$(CC) -O3 -fPIC -I$(ERLANG_PATH) -dynamiclib -undefined dynamic_lookup -o $@ $(NIF_SRC)

setuid:
	mix compile

.PHONY: all setuid
