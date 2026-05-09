.PHONY: validate

validate:
	docker run --rm \
		-v "$$(pwd):/work" \
		-w /work \
		ghcr.io/renovatebot/renovate:44.0.1 \
		renovate-config-validator default.json .renovaterc.json5
