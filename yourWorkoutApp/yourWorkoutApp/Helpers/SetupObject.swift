//
//  SetupObject.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 28.10.2021.
//

import Foundation

func setupObject<Object: AnyObject>(_ object: Object, _ closure: (Object) -> Void) -> Object {
    closure(object)
    return object
}
