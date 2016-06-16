
# Test tshark's dissectors on small test files

TEST_CASES = $(wildcard tests/*/*.pdml)

check_output = (cd $(dir $1) && \
		tshark -T pdml -r $(subst .pdml,,$(notdir $1)) > $(notdir $2) 2>&1 && \
		xsltproc filter.xsl $(notdir $2)  | diff $(notdir $1) - ) 

all: test

%.pdml.current: %.pdml %
	$(call check_output, $<, $@)

test: $(TEST_CASES:.pdml=.pdml.current)

clean:
	rm -f $(TEST_CASES:.pdml=.pdml.current)

.PHONY: clean