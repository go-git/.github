.PHONY: renovate-config-validate

renovate-config-validate:
	docker run --rm \
		-v "$$(pwd):/work" \
		-w /work \
		ghcr.io/renovatebot/renovate:41 \
		renovate-config-validator default.json .renovaterc.json5
