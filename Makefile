ERLANG_PATH = $(shell erl -eval 'io:format("~s", [lists:concat([code:root_dir(), "/erts-", erlang:system_info(version), "/include"])])' -s init stop -noshell)
CFLAGS = -g -O3 -Wall -I$(ERLANG_PATH) -Isrc

ifneq ($(CROSSCOMPILE),)
	# crosscompiling
	CFLAGS += -fPIC
else
	# not crosscompiling
	ifneq ($(OS),Windows_NT)
		CFLAGS += -fPIC

		ifeq ($(shell uname),Darwin)
			LDFLAGS += -dynamiclib -undefined dynamic_lookup
		endif
	endif
endif

all: priv/setuid.so

NIF_SRC=\
	src/setuid.c

priv/setuid.so: $(NIF_SRC)
	$(CC) $(CFLAGS) -shared $(LDFLAGS) -o $@ $(NIF_SRC)

setuid:
	mix compile

.PHONY: all setuid
