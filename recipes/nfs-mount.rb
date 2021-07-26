#
# Cookbook:: feign
# Recipe:: nfs-mount
# <
# Skip `:mount` for NFS mount resources
# >
# Copyright:: 2021, Joseph J Nuspl Jr
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.#
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
