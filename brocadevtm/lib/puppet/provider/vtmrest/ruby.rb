require_relative '../../../vtmrestcontroller'
require 'json'

Puppet::Type.type(:vtmrest).provide(:ruby) do

	def exists?

		if resource[:type] == 'purge'
			return vtmrc.puppetPurge(resource[:content])
		end

		#$stdout.puts("Notice: Content #{resource[:content]}")
		$response = vtmrc.puppetCompare(resource[:name], resource[:content], resource[:type], resource[:internal])
		if $response == true
			#$stdout.puts("Notice: Object #{resource[:name]} OK")
			return true;
		elsif $response == false
			$stderr.puts("Notice: Object #{resource[:name]} differs from catalog")
			return false
		else
			if $response == nil
				$stderr.puts("Notice: Object #{resource[:name]} does not exist")
			else
				$stderr.puts("Notice: VTM Error, REST Response #{$response.code}.")
				$stderr.puts($response.body)
			end
			return false;
		end

	end

	def create
		$stdout.puts("Notice: Creating #{resource[:name]}")
		#if ( resource[:type] == "application/json" )
		#	$stdout.puts("Notice: Content #{resource[:content]}")
		#end
		$response = vtmrc.puppetCreate(resource[:name], resource[:content], resource[:type], resource[:internal])
		if $response == nil || ( ! $response.code.start_with?("20") )
			$stderr.puts("Notice: FAILED #{resource[:name]}")
			$stderr.puts("Notice: VTM Response Code: #{$response.code}")
			$stderr.puts("Notice: VTM Response Body: #{$response.body}")
			raise(Puppet::Error, "Failed to create '#{resource[:name]}'")
			return false
		end
		return true
	end

	def destroy
		$stdout.puts("Notice: Removing #{resource[:name]}")
		vtmrc.puppetDelete(resource[:name])
	end

	private

	def vtmrc 
		uri = resource[:endpoint].split(/^https:\/\/([^:]*):([0-9]+)\/api\/tm\/([^\/]*)\/.*/)
		@vtmrc = BrocadeVTMRestController.new(uri[1], uri[2], uri[3], resource[:username], resource[:password], resource[:debug])
	end

end
