update_data:
	make fetch_raw_data
	make generate_api_data

fetch_raw_data:
	ruby bin/fetch_raw_data.rb

generate_api_data:
	ruby bin/generate_api_data.rb

update_index_html:
	ruby bin/update_index_html.rb
