import Foundation

protocol NetworkSessionProtocol {
    /// Create  a URLSessionDataTask. The caller is responsible for calling resume().
    /// - Parameters:
    ///   - request: `URLRequest` object.
    ///   - completionHandler: The completion handler for the data task.
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask?

    /// Create  a URLSessionDownloadTask. The caller is responsible for calling resume().
    /// - Parameters:
    ///   - request: `URLRequest` object.
    ///   - progressHandler: Optional `ProgressHandler` callback.
    ///   - completionHandler: The completion handler for the download task.
    func downloadTask(request: URLRequest, progressHandler: ProgressHandler?, completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) -> URLSessionDownloadTask?

    /// Create  a URLSessionUploadTask. The caller is responsible for calling resume().
    /// - Parameters:
    ///   - request: `URLRequest` object.
    ///   - fileURL: The source file `URL`.
    ///   - progressHandler: Optional `ProgressHandler` callback.
    ///   - completion: he completion handler for the upload task.
    func uploadTask(with request: URLRequest, from fileURL: URL, progressHandler: ProgressHandler?, completion: @escaping (Data?, URLResponse?, Error?)-> Void) -> URLSessionUploadTask?
}
