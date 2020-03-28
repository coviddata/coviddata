update_data:
	make fetch_source_data
	make generate_derived_data

fetch_source_data:
	ruby bin/fetch_source_data.rb

generate_derived_data:
	ruby bin/generate_derived_data.rb

update_index_html:
	ruby bin/update_index_html.rb
