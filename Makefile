check: fmt test static vet sec

.PHONY: check install-hooks git-skipchecks push-skipchecks

install-hooks:
	go install mvdan.cc/gofumpt@v0.2.0
	go install honnef.co/go/tools/cmd/staticcheck@v0.2.2
	go install github.com/securego/gosec/v2/cmd/gosec@v2.9.2
	cp scripts/hooks/pre-commit.sh .git/hooks/pre-commit
	cp scripts/hooks/pre-push.sh .git/hooks/pre-push

test:
	go test ./...

fmt:
	gofumpt -w -l .

static:
	staticcheck -checks all ./...

vet:
	go vet ./...

sec:
	gosec ./...

skipcheck-precommit:
	git commit --no-verify

skipcheck-prepush:
	git push --no-verify
	
