//
//  DTOToEntityTransformer.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 26.09.23.
//

import Foundation

protocol DTOToEntityTransformerType {
    associatedtype DTO: Codable
    associatedtype Entity: Equatable
    func transform(dto: DTO) -> Entity
}
