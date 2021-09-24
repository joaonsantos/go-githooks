check: fmt test static vet sec

.PHONY: check install-hooks git-skipchecks push-skipchecks

install-hooks:
	go install mvdan.cc/gofumpt@v0.1.1
	go install honnef.co/go/tools/cmd/staticcheck@v0.2.0
	go install github.com/securego/gosec/v2/cmd/gosec@v2.8.1
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
	go vet -vettool=$(which shadow) ./...

sec:
	gosec ./...

commit-skipchecks:
	git commit --no-verify

push-skipchecks:
	git push --no-verify
	