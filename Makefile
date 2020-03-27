update_data:
	make fetch_raw_data
	make generate_derived_data

fetch_raw_data:
	ruby bin/fetch_raw_data.rb

generate_derived_data:
	ruby bin/generate_derived_data.rb

update_index_html:
	ruby bin/update_index_html.rb
