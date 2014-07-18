#!/usr/bin/env ruby

require 'Xcodeproj'

class Xcodeproj::Project
	def subproject_refs
		subproject_refs = self.objects.select do |object|
			(object.is_a?(Xcodeproj::Project::Object::PBXFileReference) and object.to_s.downcase.include? 'xcodeproj')
		end

		return subproject_refs
	end

	def subprojects
		self.subproject_refs.map { |ref| Xcodeproj::Project.open(ref.real_path) }
	end

	def fastify
		self.targets.each do |target|
			scripts = target.shell_script_build_phases
			target.shell_script_build_phases.each do |shell_script_build_phase|
				shell_script_build_phase.shell_script = "# shell script removed. You probably don't want to commit this."
			end

			target.build_configurations.each do |build_config|
				static_analysis_keys = ['RUN_CLANG_STATIC_ANALYZER',
					'CLANG_ANALYZER_DEADCODE_DEADSTORES', 
					'CLANG_ANALYZER_GCD', 
					'CLANG_ANALYZER_MEMORY_MANAGEMENT', 
					'CLANG_ANALYZER_OBJC_ATSYNC', 
					'CLANG_ANALYZER_OBJC_COLLECTIONS', 
					'CLANG_ANALYZER_OBJC_INCOMP_METHOD_TYPES', 
					'CLANG_ANALYZER_OBJC_NSCFERROR', 
					'CLANG_ANALYZER_OBJC_RETAIN_COUNT', 
					'CLANG_ANALYZER_OBJC_SELF_INIT', 
					'CLANG_ANALYZER_OBJC_UNUSED_IVARS',
					'CLANG_ANALYZER_SECURITY_INSECUREAPI_GETPW_GETS',
					'CLANG_ANALYZER_SECURITY_INSECUREAPI_MKSTEMP',
					'CLANG_ANALYZER_SECURITY_INSECUREAPI_UNCHECKEDRETURN',
					'CLANG_ANALYZER_SECURITY_INSECUREAPI_VFORK',
					'CLANG_ANALYZER_SECURITY_KEYCHAIN_API']

				static_analysis_keys.each do |key|
					build_config.build_settings[key] = 'NO'
				end

				# Don't generate dSYM files
				build_config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
			end
		end

		self.save
	end

	def recursively_fastify
		self.fastify
		puts "#{self} has been fast-ified"

		self.subprojects.each do |subproject|
			begin
				subproject.recursively_fastify
			rescue
				puts "Could not recursively_fastify #{subproject}"
			end
		end
	end
end

# Open the existing Xcode project
project_file_path = ARGV[0]

if !project_file_path
	abort 'Whoa buddy, you need to specify an Xcode project.'
end

project = Xcodeproj::Project.open(project_file_path)

project.recursively_fastify

puts "#{project_file_path} has been fast-ified"