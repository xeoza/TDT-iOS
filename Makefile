documentation:
	@jazzy \
		--min-acl internal \
		--no-hide-documentation-coverage \
		--theme fullwidth \
		--output ./docs \
		--documentation=./*.md
		--xcodebuild-arguments -scheme, TDT-Project , -workspace, TDT-project.xcworkspace \
	@rm -rf ./build
