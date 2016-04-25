module ApplicationHelper
	def link_to_add_fields(name, f, association,locals={})
		#createa new object for the price_dets
		new_object = f.object.class.reflect_on_association(association).klass.new
		id = new_object.object_id
		fields = f.fields_for(association, new_object, child_index: id) do |builder|
			#to get the _price_det_fiels helper file
			render(association.to_s.singularize+"_fields", t:builder)
		end
		link_to(name,'#',class: [locals[:class],"add_fields"], data: {id: id,fields: fields.gsub("\n","")})
	end
end
