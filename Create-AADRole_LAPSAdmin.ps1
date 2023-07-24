
Import-Module Microsoft.Graph.DeviceManagement.Enrolment
    $params = @{
        # Basic role information
        Description = "Can view devices local admin password."
        DisplayName = "Windows LAPS Administrator"
        RolePermissions = @(
                @{
                    # Set of permissions to grant
                    AllowedResourceActions = @(
                            "microsoft.directory/deviceLocalCredentials/password/read"
                        )
                }
        )
        IsEnabled = $true
    }
    # Create new custom admin role
    # Needs this permission granted RoleManagement.ReadWrite.Directory
    New-MgRoleManagementDirectoryRoleDefinition -BodyParameter $params