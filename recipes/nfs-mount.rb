#
# Cookbook:: feign
# Recipe:: nfs-mount
# <
# Skip `:mount` for NFS mount resources
# >
# Copyright:: 2021, The Authors, All Rights Reserved.
#

Chef.event_handler do
  on :converge_start do
    Chef.run_context.resource_collection.each do |r|
      next unless r.resource_name == :mount
      next unless r.fstype == 'nfs'
      if r.action.delete(:mount)
        Chef::Log.warn "Skipping :mount for #{r}"
      end
    end
  end
end
