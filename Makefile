.PHONY: check install-hooks git-skipchecks push-skipchecks

check: fmt test static vet sec

install-hooks:
	go install mvdan.cc/gofumpt@latest
	go install honnef.co/go/tools/cmd/staticcheck@latest
	go install github.com/securego/gosec/v2/cmd/gosec@latest
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
