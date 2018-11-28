//
//  ZHReplaceString.swift
//  ReplaceString
//
//  Created by 张行 on 2018/11/28.
//  Copyright © 2018 张行. All rights reserved.
//

import Foundation

class ZHReplaceString {
    func replaceString() {
        guard CommandLine.argc >= 3 else {
            print("缺少参数")
            return
        }
        let path = CommandLine.arguments[1]
        let map = replaceStringMap()
        print(map)
        for subMap in map {
            print("\(subMap.key)  \(subMap.value)")
        }
        if let data = FileManager.default.contents(atPath: path), var content = String(data: data, encoding: String.Encoding.utf8) {
            for subMap in map {
                content = content.replacingOccurrences(of: subMap.key, with: subMap.value)
            }
            do {
                try content.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
            } catch {
                print(error)
            }
        }
    }
    
    func replaceStringMap() -> [String:String] {
        var map:[String:String] = [:]
        for item in CommandLine.arguments.enumerated() {
            guard item.offset >= 2 else {
                continue
            }
            let list = item.element.components(separatedBy: "=")
            guard list.count == 2 else {
                continue
            }
            map[list[0]] = list[1]
        }
        return map
    }
}
