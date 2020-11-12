import Alamofire
import Foundation

struct Repository: Decodable {
    var name: String
}

class ReposDecoder {
    func repos(decodedFrom data: Data) -> [Repository]? {
        do {
            let repos: [Repository] = try JSONDecoder().decode([Repository].self, from: data)
            
            return repos
        } catch {
            print("ошибка получения данных")
            
            return nil
        }
    }
}

print("введите имя пользователя: ", terminator: "")

guard let name = readLine() else {
    print("ошибка ввода")
    
    exit(0)
}

AF.request("https://api.github.com/users/\(name)/repos").responseJSON { (response) in
    switch response.result {
        case .success(_):
            
            let reposDecoder = ReposDecoder()
            guard let repos = reposDecoder.repos(decodedFrom: response.data!) else {
                exit(0)
            }
            
            if repos.isEmpty {
                print("у пользователя нет публичных репозиториев")
                
                exit(0)
            }
            
            for i in 0..<repos.count {
                print(repos[i].name)
            }
        case .failure(let error):
            print(error.localizedDescription)
    }
    exit(0)
}

RunLoop.current.run()

