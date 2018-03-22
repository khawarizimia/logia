import Foundation
import SimpleHttpClient

public class PetAPI: Swagger_Petstore_ServerSDKUtility {

    /**
        Add a new pet to the store

        - parameter body: Pet object that needs to be added to the store
        - parameter completionHandler: The callback that will be executed once the underlying HTTP call completes
        - parameter response: The HTTP response returned by the server
        - parameter error: An error that prevented a successful request
    */
    public static func addPet(body: Pet, completionHandler: @escaping (_ statusCode: Int?, _ responseHeaders: [String: String]?, _ error: HttpError?) -> Void) {


        let path = "/pet"
        let components = URLComponents(string: self.basePath + path)

        let requestUrl: URL = components!.url!

        let scheme: String  = requestUrl.scheme ?? "https" // default to https if nothing specified
        let host: String  = requestUrl.host ?? "" // get 404 instead of uwrapping nil at runtime
        var port: String?
        if let requestPort = requestUrl.port {
            port = String(requestPort)
        }

        let httpResource = HttpResource(schema: scheme, host: host, port: port, path: requestUrl.path)

        var requestHeaders: [String: String] = [:]
        requestHeaders["Accept"] = "application/json"
        requestHeaders["Content-Type"] = "application/json"
        let requestBody = try? JSONEncoder().encode(body)

        HttpClient.sendRequest(to: httpResource, method: "POST", headers: requestHeaders, data: requestBody) {
            (error: HttpError?, status: Int?, headers: [String: String]?, data: Data?) in

            guard status != nil else {
                completionHandler(nil, headers, error)
                return
            }

            completionHandler(status, headers, error)

        }
    }

    /**
        Deletes a pet

        - parameter petId: Pet id to delete
        - parameter apiKey: 
        - parameter completionHandler: The callback that will be executed once the underlying HTTP call completes
        - parameter response: The HTTP response returned by the server
        - parameter error: An error that prevented a successful request
    */
    public static func deletePet(petId: Int64, apiKey: String? = nil, completionHandler: @escaping (_ statusCode: Int?, _ responseHeaders: [String: String]?, _ error: HttpError?) -> Void) {


        var path = "/pet/{petId}"
        path = path.replacingOccurrences(of: "{petId}", with: "\(petId)")

        let components = URLComponents(string: self.basePath + path)

        let requestUrl: URL = components!.url!

        let scheme: String  = requestUrl.scheme ?? "https" // default to https if nothing specified
        let host: String  = requestUrl.host ?? "" // get 404 instead of uwrapping nil at runtime
        var port: String?
        if let requestPort = requestUrl.port {
            port = String(requestPort)
        }

        let httpResource = HttpResource(schema: scheme, host: host, port: port, path: requestUrl.path)

        var requestHeaders: [String: String] = [:]
        requestHeaders["Accept"] = "application/json"
        if let header = apiKey {
            requestHeaders["api_key"] = convertToString(header)
        }

        HttpClient.sendRequest(to: httpResource, method: "DELETE", headers: requestHeaders) {
            (error: HttpError?, status: Int?, headers: [String: String]?, data: Data?) in

            guard status != nil else {
                completionHandler(nil, headers, error)
                return
            }

            completionHandler(status, headers, error)

        }
    }

    /**
        Finds Pets by status

        - parameter status: Status values that need to be considered for filter
        - parameter completionHandler: The callback that will be executed once the underlying HTTP call completes
        - parameter returnedData: The data that this method is retrieving from the server
        - parameter response: The HTTP response returned by the server
        - parameter error: An error that prevented a successful request
    */
    public static func findPetsByStatus(status: [String], completionHandler: @escaping (_ returnedData: [Pet]?, _ statusCode: Int?, _ responseHeaders: [String: String]?, _ error: HttpError?) -> Void) {


        let path = "/pet/findByStatus"
        var components = URLComponents(string: self.basePath + path)
        var queryParameters: [URLQueryItem] = []
        status.forEach { (value) -> Void in
            queryParameters.append(URLQueryItem(name: "status", value: "\(value)"))
        }
        queryParameters = queryParameters.filter { (item) -> Bool in
            item.value != nil
        }

        if !queryParameters.isEmpty {
            components?.queryItems = queryParameters
        }

        let requestUrl: URL = components!.url!

        let scheme: String  = requestUrl.scheme ?? "https" // default to https if nothing specified
        let host: String  = requestUrl.host ?? "" // get 404 instead of uwrapping nil at runtime
        var port: String?
        if let requestPort = requestUrl.port {
            port = String(requestPort)
        }

        let httpResource = HttpResource(schema: scheme, host: host, port: port, path: requestUrl.path)

        var requestHeaders: [String: String] = [:]
        requestHeaders["Accept"] = "application/json"

        HttpClient.sendRequest(to: httpResource, method: "GET", headers: requestHeaders) {
            (error: HttpError?, status: Int?, headers: [String: String]?, data: Data?) in

            guard let status = status else {
                completionHandler(nil, nil, headers, error)
                return
            }

            guard error == nil else {
                completionHandler(nil, status, headers, error)
                return
            }

            if 200 ..< 300 ~= status,
               status == 200,
               let data = data {
                 do {
                   let returnValue = try JSONDecoder().decode([Pet].self, from: data)
                   completionHandler(returnValue, status, headers, error)
                 } catch {
                   completionHandler(nil, status, headers, .ServerError)
                 }
            } else {
                completionHandler(nil, status, headers, error)
            }
        }
    }

    /**
        Finds Pets by tags

        - parameter tags: Tags to filter by
        - parameter completionHandler: The callback that will be executed once the underlying HTTP call completes
        - parameter returnedData: The data that this method is retrieving from the server
        - parameter response: The HTTP response returned by the server
        - parameter error: An error that prevented a successful request
    */
    public static func findPetsByTags(tags: [String], completionHandler: @escaping (_ returnedData: [Pet]?, _ statusCode: Int?, _ responseHeaders: [String: String]?, _ error: HttpError?) -> Void) {


        let path = "/pet/findByTags"
        var components = URLComponents(string: self.basePath + path)
        var queryParameters: [URLQueryItem] = []
        tags.forEach { (value) -> Void in
            queryParameters.append(URLQueryItem(name: "tags", value: "\(value)"))
        }
        queryParameters = queryParameters.filter { (item) -> Bool in
            item.value != nil
        }

        if !queryParameters.isEmpty {
            components?.queryItems = queryParameters
        }

        let requestUrl: URL = components!.url!

        let scheme: String  = requestUrl.scheme ?? "https" // default to https if nothing specified
        let host: String  = requestUrl.host ?? "" // get 404 instead of uwrapping nil at runtime
        var port: String?
        if let requestPort = requestUrl.port {
            port = String(requestPort)
        }

        let httpResource = HttpResource(schema: scheme, host: host, port: port, path: requestUrl.path)

        var requestHeaders: [String: String] = [:]
        requestHeaders["Accept"] = "application/json"

        HttpClient.sendRequest(to: httpResource, method: "GET", headers: requestHeaders) {
            (error: HttpError?, status: Int?, headers: [String: String]?, data: Data?) in

            guard let status = status else {
                completionHandler(nil, nil, headers, error)
                return
            }

            guard error == nil else {
                completionHandler(nil, status, headers, error)
                return
            }

            if 200 ..< 300 ~= status,
               status == 200,
               let data = data {
                 do {
                   let returnValue = try JSONDecoder().decode([Pet].self, from: data)
                   completionHandler(returnValue, status, headers, error)
                 } catch {
                   completionHandler(nil, status, headers, .ServerError)
                 }
            } else {
                completionHandler(nil, status, headers, error)
            }
        }
    }

    /**
        Find pet by ID

        - parameter petId: ID of pet to return
        - parameter completionHandler: The callback that will be executed once the underlying HTTP call completes
        - parameter returnedData: The data that this method is retrieving from the server
        - parameter response: The HTTP response returned by the server
        - parameter error: An error that prevented a successful request
    */
    public static func getPetById(petId: Int64, completionHandler: @escaping (_ returnedData: Pet?, _ statusCode: Int?, _ responseHeaders: [String: String]?, _ error: HttpError?) -> Void) {


        var path = "/pet/{petId}"
        path = path.replacingOccurrences(of: "{petId}", with: "\(petId)")

        let components = URLComponents(string: self.basePath + path)

        let requestUrl: URL = components!.url!

        let scheme: String  = requestUrl.scheme ?? "https" // default to https if nothing specified
        let host: String  = requestUrl.host ?? "" // get 404 instead of uwrapping nil at runtime
        var port: String?
        if let requestPort = requestUrl.port {
            port = String(requestPort)
        }

        let httpResource = HttpResource(schema: scheme, host: host, port: port, path: requestUrl.path)

        var requestHeaders: [String: String] = [:]
        requestHeaders["Accept"] = "application/json"

        if let apiKey = Swagger_Petstore_ServerSDKUtility.apiKeys["api_key"] {
            requestHeaders["api_key"] = apiKey
        }

        HttpClient.sendRequest(to: httpResource, method: "GET", headers: requestHeaders) {
            (error: HttpError?, status: Int?, headers: [String: String]?, data: Data?) in

            guard let status = status else {
                completionHandler(nil, nil, headers, error)
                return
            }

            guard error == nil else {
                completionHandler(nil, status, headers, error)
                return
            }

            if 200 ..< 300 ~= status,
               status == 200,
               let data = data {
                 do {
                   let returnValue = try JSONDecoder().decode(Pet.self, from: data)
                   completionHandler(returnValue, status, headers, error)
                 } catch {
                   completionHandler(nil, status, headers, .ServerError)
                 }
            } else {
                completionHandler(nil, status, headers, error)
            }
        }
    }

    /**
        Update an existing pet

        - parameter body: Pet object that needs to be added to the store
        - parameter completionHandler: The callback that will be executed once the underlying HTTP call completes
        - parameter response: The HTTP response returned by the server
        - parameter error: An error that prevented a successful request
    */
    public static func updatePet(body: Pet, completionHandler: @escaping (_ statusCode: Int?, _ responseHeaders: [String: String]?, _ error: HttpError?) -> Void) {


        let path = "/pet"
        let components = URLComponents(string: self.basePath + path)

        let requestUrl: URL = components!.url!

        let scheme: String  = requestUrl.scheme ?? "https" // default to https if nothing specified
        let host: String  = requestUrl.host ?? "" // get 404 instead of uwrapping nil at runtime
        var port: String?
        if let requestPort = requestUrl.port {
            port = String(requestPort)
        }

        let httpResource = HttpResource(schema: scheme, host: host, port: port, path: requestUrl.path)

        var requestHeaders: [String: String] = [:]
        requestHeaders["Accept"] = "application/json"
        requestHeaders["Content-Type"] = "application/json"
        let requestBody = try? JSONEncoder().encode(body)

        HttpClient.sendRequest(to: httpResource, method: "PUT", headers: requestHeaders, data: requestBody) {
            (error: HttpError?, status: Int?, headers: [String: String]?, data: Data?) in

            guard status != nil else {
                completionHandler(nil, headers, error)
                return
            }

            completionHandler(status, headers, error)

        }
    }

    /**
        Updates a pet in the store with form data

        - parameter petId: ID of pet that needs to be updated
        - parameter name: Updated name of the pet
        - parameter status: Updated status of the pet
        - parameter completionHandler: The callback that will be executed once the underlying HTTP call completes
        - parameter response: The HTTP response returned by the server
        - parameter error: An error that prevented a successful request
    */
    public static func updatePetWithForm(petId: Int64, name: String? = nil, status: String? = nil, completionHandler: @escaping (_ statusCode: Int?, _ responseHeaders: [String: String]?, _ error: HttpError?) -> Void) {


        var path = "/pet/{petId}"
        path = path.replacingOccurrences(of: "{petId}", with: "\(petId)")

        let components = URLComponents(string: self.basePath + path)

        let requestUrl: URL = components!.url!

        let scheme: String  = requestUrl.scheme ?? "https" // default to https if nothing specified
        let host: String  = requestUrl.host ?? "" // get 404 instead of uwrapping nil at runtime
        var port: String?
        if let requestPort = requestUrl.port {
            port = String(requestPort)
        }

        let httpResource = HttpResource(schema: scheme, host: host, port: port, path: requestUrl.path)

        var requestHeaders: [String: String] = [:]
        requestHeaders["Accept"] = "application/json"
        requestHeaders["Content-Type"] = "application/x-www-form-urlencoded"

        var formParameters: [String: String?] = [:]
        formParameters["name"] = name?.description
        formParameters["status"] = status?.description

        let requestBody = formParameters.map({ (key, value) -> String in
            "\(key)=\(String(describing: value))"
        })
        .reduce("", { (result, string) -> String in
            result.isEmpty ? string : "\(result)&\(string)"
        })
        .data(using: .utf8)!

        HttpClient.sendRequest(to: httpResource, method: "POST", headers: requestHeaders, data: requestBody) {
            (error: HttpError?, status: Int?, headers: [String: String]?, data: Data?) in

            guard status != nil else {
                completionHandler(nil, headers, error)
                return
            }

            completionHandler(status, headers, error)

        }
    }

    /**
        uploads an image

        - parameter petId: ID of pet to update
        - parameter additionalMetadata: Additional data to pass to server
        - parameter file: file to upload
        - parameter completionHandler: The callback that will be executed once the underlying HTTP call completes
        - parameter returnedData: The data that this method is retrieving from the server
        - parameter response: The HTTP response returned by the server
        - parameter error: An error that prevented a successful request
    */
    public static func uploadFile(petId: Int64, additionalMetadata: String? = nil, file: URL? = nil, completionHandler: @escaping (_ returnedData: ApiResponse?, _ statusCode: Int?, _ responseHeaders: [String: String]?, _ error: HttpError?) -> Void) throws {


        let uuid = UUID()
        let boundary = "----\(uuid.uuidString)"

        var path = "/pet/{petId}/uploadImage"
        path = path.replacingOccurrences(of: "{petId}", with: "\(petId)")

        let components = URLComponents(string: self.basePath + path)

        let requestUrl: URL = components!.url!

        let scheme: String  = requestUrl.scheme ?? "https" // default to https if nothing specified
        let host: String  = requestUrl.host ?? "" // get 404 instead of uwrapping nil at runtime
        var port: String?
        if let requestPort = requestUrl.port {
            port = String(requestPort)
        }

        let httpResource = HttpResource(schema: scheme, host: host, port: port, path: requestUrl.path)

        var requestHeaders: [String: String] = [:]
        requestHeaders["Accept"] = "application/json"
        requestHeaders["Content-Type"] = "multipart/form-data; boundary=\(boundary)"

        var formParameters: [String: String?] = [:]
        formParameters["additionalMetadata"] = additionalMetadata?.description

        var requestBody = formParameters.map ({ (key, value) -> String in
            "\(boundary)\r\n" +
            "Content-Disposition: form-data; name=\"\(key)\"\r\n" +
            "\r\n" +
            "\(value)\r\n"
        })
        .reduce("", { (result, string) -> String in
            result + string
        })
        .data(using: .utf8)!

        if let file = file {
            requestBody.append(("\(boundary)\r\n" +
                        "Content-Disposition: form-data; name=\"file\"; filename=\"\(file.lastPathComponent)\"\r\n" +
                        "\r\n").data(using: .utf8)!)
            try requestBody.append(Data(contentsOf: file as URL))
            requestBody.append("\r\n".data(using: .utf8)!)
        }

        HttpClient.sendRequest(to: httpResource, method: "POST", headers: requestHeaders, data: requestBody) {
            (error: HttpError?, status: Int?, headers: [String: String]?, data: Data?) in

            guard let status = status else {
                completionHandler(nil, nil, headers, error)
                return
            }

            guard error == nil else {
                completionHandler(nil, status, headers, error)
                return
            }

            if 200 ..< 300 ~= status,
               status == 200,
               let data = data {
                 do {
                   let returnValue = try JSONDecoder().decode(ApiResponse.self, from: data)
                   completionHandler(returnValue, status, headers, error)
                 } catch {
                   completionHandler(nil, status, headers, .ServerError)
                 }
            } else {
                completionHandler(nil, status, headers, error)
            }
        }
    }
}
