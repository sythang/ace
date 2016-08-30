module API
	module V1
		module Entities
			class Success < Grape::Entity
	      expose :code, documentation: { type: "string" }
	      expose :message, documentation: { type: "string" }
	    end
			class Error < Grape::Entity
	    	expose :code, documentation: {type: "string"}
	    	expose :message, documentation: {type: "string"}
	    	expose :messages, documentation: {type: "string", is_array: true}
	  	end
			class User < Grape::Entity
				expose :id, documentation: {type: Integer}
				expose :name, documentation: {type: String}
				expose :email, documentation: {type: String}
				expose :role, documentation: {type: String}
				expose :api_token, documentation: { type: "String" }, if: lambda { |instance, options| options[:show_api_key] }
			end

			class Test < Grape::Entity
				root 'tests', 'test'
				expose :id, documentation: {type: Integer}
				expose :name, documentation: {type: String}
				expose :description, documentation: {type: String}
			end

			class Option < Grape::Entity
				expose :id, documentation: {type: Integer}
				expose :content, documentation: {type: String}
				expose :is_correct_answer, documentation: {type: 'boolean'}
			end

			class Question < Grape::Entity
				expose :id, documentation: {type: Integer}
				expose :label, documentation: {type: String}
				expose :description, documentation: {type: String}
				expose :options, documentation: {type: Option, is_array: true} do |instance, options|
					Option.represent(instance.options)
				end
			end

			class TestDetail < Grape::Entity
				root 'tests', 'test'
				expose :id, documentation: {type: Integer}
				expose :name, documentation: {type: String}
				expose :description, documentation: {type: String}
				expose :questions, using: Question, documentation: {type: Question, is_array: true}
			end
		end
	end
end