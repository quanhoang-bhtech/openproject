#-- copyright
# OpenProject is an open source project management software.
# Copyright (C) 2012-2023 the OpenProject GmbH
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2013 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See COPYRIGHT and LICENSE files for more details.
#++

# Create memberships like this:
#
#   project = create(:project)
#   user    = create(:user)
#   role    = create(:role, permissions: [:view_wiki_pages, :edit_wiki_pages])
#
#   member = create(:member, user: user, project: project)
#   member.role_ids = [role.id]
#   member.save!
#
# It looks like you cannot create member_role models directly.

FactoryBot.define do
  factory :member do
    project

    transient do
      user { nil }
    end

    callback(:after_build) do |member, options|
      member.principal ||= options.user || build(:user)
    end

    callback(:after_stub) do |member, options|
      member.principal ||= options.user || build_stubbed(:user)
    end
  end

  factory :global_member, parent: :member do
    project { nil }
  end
end
