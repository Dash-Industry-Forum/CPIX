$ErrorActionPreference = "Stop"

# This file contains functions shared by several other scripts.

# PowerShell does not currently have a good way to do the POST in the required format for
# making use of the Bikeshed public web API. Therefore, we use a C# class to do what we need.

# The goal is to emulate the following:
# curl https://api.csswg.org/bikeshed/ -F file=@Cpix.bs -F force=1

$references = @(
    "System.Net.Http, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
)

$code = @"
using System;
using System.IO;
using System.Net.Http;

public sealed class Bikeshed
{
    public static void Validate(string path)
    {
        using (var client = new HttpClient())
        using (var formData = new MultipartFormDataContent())
        using (var inputFile = File.OpenRead(path))
        {
            formData.Add(new StreamContent(inputFile), "file", "File.bs");
            formData.Add(new StringContent("err"), "output");

            var response = client.PostAsync("https://api.csswg.org/bikeshed/", formData).Result;

            var result = response.Content.ReadAsStringAsync().Result;

            // Code 200 means validation passed.
            // Code 400 means validation failed.
            // We just parse output because that gives more details.

            if (string.IsNullOrWhiteSpace(result))
            {
                Console.WriteLine("Validation successful.");
            }
            else
            {
                Console.Error.WriteLine(result);
                throw new Exception("Bikeshed validation failed.");
            }
        }
    }

    public static string Compile(string path, bool ignoreErrors)
    {
        using (var client = new HttpClient())
        using (var formData = new MultipartFormDataContent())
        using (var inputFile = File.OpenRead(path))
        {
            formData.Add(new StreamContent(inputFile), "file", "File.bs");

            if (ignoreErrors)
                formData.Add(new StringContent("1"), "force");

            var response = client.PostAsync("https://api.csswg.org/bikeshed/", formData).Result;

            var result = response.Content.ReadAsStringAsync().Result;

            // Code 200 means build passed.
            // Code 400 means build failed.

            if (response.IsSuccessStatusCode)
            {
                return result;
            }
            else
            {
                Console.Error.WriteLine(result);
                throw new Exception("Build failed - see above log for errors.");
            }
        }
    }
}
"@

# Only define it once, to avoid conflicts.
if (!$bikeshedTypeIsDefined) {
    Add-Type -TypeDefinition $code -ReferencedAssemblies $references -Language CSharp

    New-Variable -Scope Global -Name bikeshedTypeIsDefined -Value $true -Option Constant
}
else {
    Write-Verbose "Bikeshed type is already defined - will not add it again."
}