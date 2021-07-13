// Generated using Sourcery 1.4.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import CoreDataGenerator
import CoreData
import Foundation

extension CoreDataEntity {
    static let coreDataStore_v100 = CoreDataStore(with: DataStoreVersion.v100)

    static func loadEntityDescriptions_v100() {
        // MARK: - ManagedAirplane Entity Definitions
        let airplaneDescription = coreDataStore_v100.entityDescription(for: "ManagedAirplane")
        var airplaneProperties: [NSPropertyDescription] = []
        // MARK: - Airplane Entity Relationship Declarations
        // MARK: - ManagedBasicStruct Entity Definitions
        let basicStructDescription = coreDataStore_v100.entityDescription(for: "ManagedBasicStruct")
        var basicStructProperties: [NSPropertyDescription] = []
        // MARK: - BasicStruct Entity Relationship Declarations
        // MARK: - ManagedCar Entity Definitions
        let carDescription = coreDataStore_v100.entityDescription(for: "ManagedCar")
        var carProperties: [NSPropertyDescription] = []
        // MARK: - Car Entity Relationship Declarations
        // MARK: - ManagedChildNestedClass Entity Definitions
        let childNestedClassDescription = coreDataStore_v100.entityDescription(for: "ManagedChildNestedClass")
        var childNestedClassProperties: [NSPropertyDescription] = []
        // MARK: - ChildNestedClass Entity Relationship Declarations
        // MARK: - ManagedChildRecursiveClass Entity Definitions
        let childRecursiveClassDescription = coreDataStore_v100.entityDescription(for: "ManagedChildRecursiveClass")
        var childRecursiveClassProperties: [NSPropertyDescription] = []
        // MARK: - ChildRecursiveClass Entity Relationship Declarations
        let childRecursiveClassGrandchildRelationship = NSRelationshipDescription()
        let childRecursiveClassInverseGrandchildRelationship = NSRelationshipDescription()
        let childRecursiveClassParentRelationship = NSRelationshipDescription()
        let childRecursiveClassInverseParentRelationship = NSRelationshipDescription()
        // MARK: - ManagedChildStruct Entity Definitions
        let childStructDescription = coreDataStore_v100.entityDescription(for: "ManagedChildStruct")
        var childStructProperties: [NSPropertyDescription] = []
        // MARK: - ChildStruct Entity Relationship Declarations
        let childStructChildRelationship = NSRelationshipDescription()
        let childStructInverseChildRelationship = NSRelationshipDescription()
        let childStructProjectsRelationship = NSRelationshipDescription()
        let childStructInverseProjectsRelationship = NSRelationshipDescription()
        // MARK: - ManagedGrandChild Entity Definitions
        let grandChildDescription = coreDataStore_v100.entityDescription(for: "ManagedGrandChild")
        var grandChildProperties: [NSPropertyDescription] = []
        // MARK: - GrandChild Entity Relationship Declarations
        // MARK: - ManagedGrandchildRecursiveClass Entity Definitions
        let grandchildRecursiveClassDescription = coreDataStore_v100.entityDescription(for: "ManagedGrandchildRecursiveClass")
        var grandchildRecursiveClassProperties: [NSPropertyDescription] = []
        // MARK: - GrandchildRecursiveClass Entity Relationship Declarations
        let grandchildRecursiveClassGrandfatherRelationship = NSRelationshipDescription()
        let grandchildRecursiveClassInverseGrandfatherRelationship = NSRelationshipDescription()
        // MARK: - ManagedGroupStruct Entity Definitions
        let groupStructDescription = coreDataStore_v100.entityDescription(for: "ManagedGroupStruct")
        var groupStructProperties: [NSPropertyDescription] = []
        // MARK: - GroupStruct Entity Relationship Declarations
        // MARK: - ManagedMainEntity Entity Definitions
        let mainEntityDescription = coreDataStore_v100.entityDescription(for: "ManagedMainEntity")
        var mainEntityProperties: [NSPropertyDescription] = []
        // MARK: - MainEntity Entity Relationship Declarations
        let mainEntityNestedFieldRelationship = NSRelationshipDescription()
        let mainEntityInverseNestedFieldRelationship = NSRelationshipDescription()
        // MARK: - ManagedMigration Entity Definitions
        let migrationDescription = coreDataStore_v100.entityDescription(for: "ManagedMigration")
        var migrationProperties: [NSPropertyDescription] = []
        // MARK: - Migration Entity Relationship Declarations
        // MARK: - ManagedNestedEntity Entity Definitions
        let nestedEntityDescription = coreDataStore_v100.entityDescription(for: "ManagedNestedEntity")
        var nestedEntityProperties: [NSPropertyDescription] = []
        // MARK: - NestedEntity Entity Relationship Declarations
        // MARK: - ManagedParentNestedClass Entity Definitions
        let parentNestedClassDescription = coreDataStore_v100.entityDescription(for: "ManagedParentNestedClass")
        var parentNestedClassProperties: [NSPropertyDescription] = []
        // MARK: - ParentNestedClass Entity Relationship Declarations
        let parentNestedClassChildRelationship = NSRelationshipDescription()
        let parentNestedClassInverseChildRelationship = NSRelationshipDescription()
        // MARK: - ManagedParentRecursiveClass Entity Definitions
        let parentRecursiveClassDescription = coreDataStore_v100.entityDescription(for: "ManagedParentRecursiveClass")
        var parentRecursiveClassProperties: [NSPropertyDescription] = []
        // MARK: - ParentRecursiveClass Entity Relationship Declarations
        let parentRecursiveClassChildRelationship = NSRelationshipDescription()
        let parentRecursiveClassInverseChildRelationship = NSRelationshipDescription()
        // MARK: - ManagedParentStruct Entity Definitions
        let parentStructDescription = coreDataStore_v100.entityDescription(for: "ManagedParentStruct")
        var parentStructProperties: [NSPropertyDescription] = []
        // MARK: - ParentStruct Entity Relationship Declarations
        let parentStructChildRelationship = NSRelationshipDescription()
        let parentStructInverseChildRelationship = NSRelationshipDescription()
        // MARK: - ManagedPerson Entity Definitions
        let personDescription = coreDataStore_v100.entityDescription(for: "ManagedPerson")
        var personProperties: [NSPropertyDescription] = []
        // MARK: - Person Entity Relationship Declarations
        let workingActivityWorkArrayAtRelationship = NSRelationshipDescription()
        let inverseWorkingActivityWorkArrayRelationship = NSRelationshipDescription()
        let drivingActivityCarVehicleRelationship = NSRelationshipDescription()
        let inverseDrivingActivityCarRelationship = NSRelationshipDescription()
        let flyingActivityAirplaneVehicleRelationship = NSRelationshipDescription()
        let inverseFlyingActivityAirplaneRelationship = NSRelationshipDescription()
        // MARK: - ManagedProduct Entity Definitions
        let productDescription = coreDataStore_v100.entityDescription(for: "ManagedProduct")
        var productProperties: [NSPropertyDescription] = []
        // MARK: - Product Entity Relationship Declarations
        let productServicesRelationship = NSRelationshipDescription()
        let productInverseServicesRelationship = NSRelationshipDescription()
        // MARK: - ManagedProject Entity Definitions
        let projectDescription = coreDataStore_v100.entityDescription(for: "ManagedProject")
        var projectProperties: [NSPropertyDescription] = []
        // MARK: - Project Entity Relationship Declarations
        // MARK: - ManagedSelfReferencedClass Entity Definitions
        let selfReferencedClassDescription = coreDataStore_v100.entityDescription(for: "ManagedSelfReferencedClass")
        var selfReferencedClassProperties: [NSPropertyDescription] = []
        // MARK: - SelfReferencedClass Entity Relationship Declarations
        let selfReferencedClassChildRelationship = NSRelationshipDescription()
        let selfReferencedClassInverseChildRelationship = NSRelationshipDescription()
        // MARK: - ManagedService Entity Definitions
        let serviceDescription = coreDataStore_v100.entityDescription(for: "ManagedService")
        var serviceProperties: [NSPropertyDescription] = []
        // MARK: - Service Entity Relationship Declarations
        // MARK: - ManagedStructs Entity Definitions
        let structsDescription = coreDataStore_v100.entityDescription(for: "ManagedStructs")
        var structsProperties: [NSPropertyDescription] = []
        // MARK: - Structs Entity Relationship Declarations
        // MARK: - ManagedWork Entity Definitions
        let workDescription = coreDataStore_v100.entityDescription(for: "ManagedWork")
        var workProperties: [NSPropertyDescription] = []
        // MARK: - Work Entity Relationship Declarations

        // Airplane.airplaneIdAttribute Attribute
        airplaneProperties.append(create(attribute: "id", type: attributeType(for: "id", ofType: String?.self), isOptional: true))

        // Airplane.airplaneNameAttribute Attribute
        airplaneProperties.append(create(attribute: "name", type: attributeType(for: "name", ofType: String.self), isOptional: false))
        airplaneProperties.append(create(attribute: "lfCoreDataEntityIsPopulated", type: .booleanAttributeType, isOptional: false, defaultValue: false))
        airplaneProperties.append(create(attribute: "lfCoreDataEntityGroupIdentifier", type: .stringAttributeType, isOptional: true))
        airplaneDescription.properties = airplaneProperties

        // BasicStruct.basicStructIdAttribute Attribute
        basicStructProperties.append(create(attribute: "id", type: attributeType(for: "id", ofType: String.self), isOptional: false))

        // BasicStruct.basicStructOtherValueAttribute Attribute
        basicStructProperties.append(create(attribute: "otherValue", type: attributeType(for: "otherValue", ofType: Int.self), isOptional: false))
        basicStructProperties.append(create(attribute: "lfCoreDataEntityIsPopulated", type: .booleanAttributeType, isOptional: false, defaultValue: false))
        basicStructProperties.append(create(attribute: "lfCoreDataEntityGroupIdentifier", type: .stringAttributeType, isOptional: true))
        basicStructDescription.properties = basicStructProperties

        // Car.carIdAttribute Attribute
        carProperties.append(create(attribute: "id", type: attributeType(for: "id", ofType: String?.self), isOptional: true))

        // Car.carManufacturerAttribute Attribute
        carProperties.append(create(attribute: "manufacturer", type: attributeType(for: "manufacturer", ofType: String.self), isOptional: false))

        // Car.carNameAttribute Attribute
        carProperties.append(create(attribute: "name", type: attributeType(for: "name", ofType: String.self), isOptional: false))
        carProperties.append(create(attribute: "lfCoreDataEntityIsPopulated", type: .booleanAttributeType, isOptional: false, defaultValue: false))
        carProperties.append(create(attribute: "lfCoreDataEntityGroupIdentifier", type: .stringAttributeType, isOptional: true))
        carDescription.properties = carProperties

        // ChildNestedClass.childNestedClassIdAttribute Attribute
        childNestedClassProperties.append(create(attribute: "id", type: attributeType(for: "id", ofType: String.self), isOptional: false))

        // ChildNestedClass.childNestedClassNameAttribute Attribute
        childNestedClassProperties.append(create(attribute: "name", type: attributeType(for: "name", ofType: String.self), isOptional: false))
        childNestedClassProperties.append(create(attribute: "lfCoreDataEntityIsPopulated", type: .booleanAttributeType, isOptional: false, defaultValue: false))
        childNestedClassProperties.append(create(attribute: "lfCoreDataEntityGroupIdentifier", type: .stringAttributeType, isOptional: true))
        childNestedClassDescription.properties = childNestedClassProperties

        // ChildRecursiveClass.childRecursiveClassIdAttribute Attribute
        childRecursiveClassProperties.append(create(attribute: "id", type: attributeType(for: "id", ofType: String.self), isOptional: false))

        // ChildRecursiveClass.childRecursiveClassNameAttribute Attribute
        childRecursiveClassProperties.append(create(attribute: "name", type: attributeType(for: "name", ofType: String.self), isOptional: false))


        childRecursiveClassProperties.append(create(attribute: "lfCoreDataEntityIsPopulated", type: .booleanAttributeType, isOptional: false, defaultValue: false))
        childRecursiveClassProperties.append(create(attribute: "lfCoreDataEntityGroupIdentifier", type: .stringAttributeType, isOptional: true))
        childRecursiveClassDescription.properties = childRecursiveClassProperties

        // ChildStruct.childStructIdAttribute Attribute
        childStructProperties.append(create(attribute: "id", type: attributeType(for: "id", ofType: String.self), isOptional: false))

        // ChildStruct.childStructNameAttribute Attribute
        childStructProperties.append(create(attribute: "name", type: attributeType(for: "name", ofType: String.self), isOptional: false))

        // ChildStruct.childStructAgeAttribute Attribute
        childStructProperties.append(create(attribute: "age", type: attributeType(for: "age", ofType: Int.self), isOptional: false))


        childStructProperties.append(create(attribute: "lfCoreDataEntityIsPopulated", type: .booleanAttributeType, isOptional: false, defaultValue: false))
        childStructProperties.append(create(attribute: "lfCoreDataEntityGroupIdentifier", type: .stringAttributeType, isOptional: true))
        childStructDescription.properties = childStructProperties

        // GrandChild.grandChildIdAttribute Attribute
        grandChildProperties.append(create(attribute: "id", type: attributeType(for: "id", ofType: String.self), isOptional: false))

        // GrandChild.grandChildFirstNameAttribute Attribute
        grandChildProperties.append(create(attribute: "firstName", type: attributeType(for: "firstName", ofType: String.self), isOptional: false))

        // GrandChild.grandChildAgeAttribute Attribute
        grandChildProperties.append(create(attribute: "age", type: attributeType(for: "age", ofType: Int.self), isOptional: false))
        grandChildProperties.append(create(attribute: "lfCoreDataEntityIsPopulated", type: .booleanAttributeType, isOptional: false, defaultValue: false))
        grandChildProperties.append(create(attribute: "lfCoreDataEntityGroupIdentifier", type: .stringAttributeType, isOptional: true))
        grandChildDescription.properties = grandChildProperties

        // GrandchildRecursiveClass.grandchildRecursiveClassIdAttribute Attribute
        grandchildRecursiveClassProperties.append(create(attribute: "id", type: attributeType(for: "id", ofType: String.self), isOptional: false))

        // GrandchildRecursiveClass.grandchildRecursiveClassNameAttribute Attribute
        grandchildRecursiveClassProperties.append(create(attribute: "name", type: attributeType(for: "name", ofType: String.self), isOptional: false))

        grandchildRecursiveClassProperties.append(create(attribute: "lfCoreDataEntityIsPopulated", type: .booleanAttributeType, isOptional: false, defaultValue: false))
        grandchildRecursiveClassProperties.append(create(attribute: "lfCoreDataEntityGroupIdentifier", type: .stringAttributeType, isOptional: true))
        grandchildRecursiveClassDescription.properties = grandchildRecursiveClassProperties

        // GroupStruct.groupStructIdAttribute Attribute
        groupStructProperties.append(create(attribute: "id", type: attributeType(for: "id", ofType: String.self), isOptional: false))

        // GroupStruct.groupStructGroupAttribute Attribute
        groupStructProperties.append(create(attribute: "group", type: attributeType(for: "group", ofType: String.self), isOptional: false))
        groupStructProperties.append(create(attribute: "lfCoreDataEntityIsPopulated", type: .booleanAttributeType, isOptional: false, defaultValue: false))
        groupStructProperties.append(create(attribute: "lfCoreDataEntityGroupIdentifier", type: .stringAttributeType, isOptional: true))
        groupStructDescription.properties = groupStructProperties

        // MainEntity.mainEntityIdAttribute Attribute
        mainEntityProperties.append(create(attribute: "id", type: attributeType(for: "id", ofType: String.self), isOptional: false))

        // MainEntity.mainEntityDetailsAttribute Attribute
        mainEntityProperties.append(create(attribute: "details", type: attributeType(for: "details", ofType: String.self), isOptional: false))

        mainEntityProperties.append(create(attribute: "lfCoreDataEntityIsPopulated", type: .booleanAttributeType, isOptional: false, defaultValue: false))
        mainEntityProperties.append(create(attribute: "lfCoreDataEntityGroupIdentifier", type: .stringAttributeType, isOptional: true))
        mainEntityDescription.properties = mainEntityProperties

        // Migration.migrationIdAttribute Attribute
        migrationProperties.append(create(attribute: "id", type: attributeType(for: "id", ofType: String.self), isOptional: false))
        migrationProperties.append(create(attribute: "lfCoreDataEntityIsPopulated", type: .booleanAttributeType, isOptional: false, defaultValue: false))
        migrationProperties.append(create(attribute: "lfCoreDataEntityGroupIdentifier", type: .stringAttributeType, isOptional: true))
        migrationDescription.properties = migrationProperties

        // NestedEntity.nestedEntityIdAttribute Attribute
        nestedEntityProperties.append(create(attribute: "id", type: attributeType(for: "id", ofType: String.self), isOptional: false))

        // NestedEntity.nestedEntityInfoAttribute Attribute
        nestedEntityProperties.append(create(attribute: "info", type: attributeType(for: "info", ofType: String.self), isOptional: false))
        nestedEntityProperties.append(create(attribute: "lfCoreDataEntityIsPopulated", type: .booleanAttributeType, isOptional: false, defaultValue: false))
        nestedEntityProperties.append(create(attribute: "lfCoreDataEntityGroupIdentifier", type: .stringAttributeType, isOptional: true))
        nestedEntityDescription.properties = nestedEntityProperties

        // ParentNestedClass.parentNestedClassIdAttribute Attribute
        parentNestedClassProperties.append(create(attribute: "id", type: attributeType(for: "id", ofType: String.self), isOptional: false))

        // ParentNestedClass.parentNestedClassNameAttribute Attribute
        parentNestedClassProperties.append(create(attribute: "name", type: attributeType(for: "name", ofType: String.self), isOptional: false))

        parentNestedClassProperties.append(create(attribute: "lfCoreDataEntityIsPopulated", type: .booleanAttributeType, isOptional: false, defaultValue: false))
        parentNestedClassProperties.append(create(attribute: "lfCoreDataEntityGroupIdentifier", type: .stringAttributeType, isOptional: true))
        parentNestedClassDescription.properties = parentNestedClassProperties

        // ParentRecursiveClass.parentRecursiveClassIdAttribute Attribute
        parentRecursiveClassProperties.append(create(attribute: "id", type: attributeType(for: "id", ofType: String.self), isOptional: false))

        // ParentRecursiveClass.parentRecursiveClassNameAttribute Attribute
        parentRecursiveClassProperties.append(create(attribute: "name", type: attributeType(for: "name", ofType: String.self), isOptional: false))

        parentRecursiveClassProperties.append(create(attribute: "lfCoreDataEntityIsPopulated", type: .booleanAttributeType, isOptional: false, defaultValue: false))
        parentRecursiveClassProperties.append(create(attribute: "lfCoreDataEntityGroupIdentifier", type: .stringAttributeType, isOptional: true))
        parentRecursiveClassDescription.properties = parentRecursiveClassProperties

        // ParentStruct.parentStructIdAttribute Attribute
        parentStructProperties.append(create(attribute: "id", type: attributeType(for: "id", ofType: String.self), isOptional: false))

        // ParentStruct.parentStructYearAttribute Attribute
        parentStructProperties.append(create(attribute: "year", type: attributeType(for: "year", ofType: Int.self), isOptional: false))

        // ParentStruct.parentStructTagAttribute Attribute
        parentStructProperties.append(create(attribute: "tag", type: attributeType(for: "tag", ofType: Int.self), isOptional: false))

        // ParentStruct.parentStructChildIdAttribute Attribute
        parentStructProperties.append(create(attribute: "childId", type: attributeType(for: "childId", ofType: String.self), isOptional: false))

        parentStructProperties.append(create(attribute: "lfCoreDataEntityIsPopulated", type: .booleanAttributeType, isOptional: false, defaultValue: false))
        parentStructProperties.append(create(attribute: "lfCoreDataEntityGroupIdentifier", type: .stringAttributeType, isOptional: true))
        parentStructDescription.properties = parentStructProperties

        // Person.personIdAttribute Attribute
        personProperties.append(create(attribute: "id", type: attributeType(for: "id", ofType: String?.self), isOptional: true))

        // Person.personActivityAttribute Attribute
        personProperties.append(create(attribute: "sleepingActivity", type: attributeType(for: "sleepingActivity", ofType: String.self), isOptional: true))
        // Person.personActivityAttribute Attribute
        personProperties.append(create(attribute: "workingActivityStringArrayWith", type: attributeType(for: "workingActivityStringArrayWith", ofType: [String].self), isOptional: true))
        // Person.personActivityAttribute Attribute
        personProperties.append(create(attribute: "walkingActivityString", type: attributeType(for: "walkingActivityString", ofType: String.self), isOptional: true))
        // Person.personActivityAttribute Attribute
        personProperties.append(create(attribute: "runningActivityString0", type: attributeType(for: "runningActivityString0", ofType: String.self), isOptional: true))
        // Person.personActivityAttribute Attribute
        personProperties.append(create(attribute: "runningActivityString1", type: attributeType(for: "runningActivityString1", ofType: String.self), isOptional: true))
        // Person.personActivityAttribute Attribute
        personProperties.append(create(attribute: "flyingActivityStringDescription", type: attributeType(for: "flyingActivityStringDescription", ofType: String.self), isOptional: true))
        // Person.personActivityAttribute Attribute
        personProperties.append(create(attribute: "flyingActivityString2", type: attributeType(for: "flyingActivityString2", ofType: String.self), isOptional: true))
        personProperties.append(create(attribute: "lfCoreDataEntityIsPopulated", type: .booleanAttributeType, isOptional: false, defaultValue: false))
        personProperties.append(create(attribute: "lfCoreDataEntityGroupIdentifier", type: .stringAttributeType, isOptional: true))
        personDescription.properties = personProperties

        // Product.productIdAttribute Attribute
        productProperties.append(create(attribute: "id", type: attributeType(for: "id", ofType: String.self), isOptional: false))

        // Product.productNameAttribute Attribute
        productProperties.append(create(attribute: "name", type: attributeType(for: "name", ofType: String.self), isOptional: false))

        // Product.productServiceIdsAttribute Attribute
        productProperties.append(create(attribute: "serviceIds", type: attributeType(for: "serviceIds", ofType: [String].self), isOptional: false))

        productProperties.append(create(attribute: "lfCoreDataEntityIsPopulated", type: .booleanAttributeType, isOptional: false, defaultValue: false))
        productProperties.append(create(attribute: "lfCoreDataEntityGroupIdentifier", type: .stringAttributeType, isOptional: true))
        productDescription.properties = productProperties

        // Project.projectIdAttribute Attribute
        projectProperties.append(create(attribute: "id", type: attributeType(for: "id", ofType: String.self), isOptional: false))

        // Project.projectDurationInMonthsAttribute Attribute
        projectProperties.append(create(attribute: "durationInMonths", type: attributeType(for: "durationInMonths", ofType: Int.self), isOptional: false))

        // Project.projectDescriptionAttribute Attribute
        projectProperties.append(create(attribute: "desc", type: attributeType(for: "description", ofType: String.self), isOptional: false))
        projectProperties.append(create(attribute: "lfCoreDataEntityIsPopulated", type: .booleanAttributeType, isOptional: false, defaultValue: false))
        projectProperties.append(create(attribute: "lfCoreDataEntityGroupIdentifier", type: .stringAttributeType, isOptional: true))
        projectDescription.properties = projectProperties

        // SelfReferencedClass.selfReferencedClassIdAttribute Attribute
        selfReferencedClassProperties.append(create(attribute: "id", type: attributeType(for: "id", ofType: String.self), isOptional: false))

        // SelfReferencedClass.selfReferencedClassNameAttribute Attribute
        selfReferencedClassProperties.append(create(attribute: "name", type: attributeType(for: "name", ofType: String.self), isOptional: false))

        selfReferencedClassProperties.append(create(attribute: "lfCoreDataEntityIsPopulated", type: .booleanAttributeType, isOptional: false, defaultValue: false))
        selfReferencedClassProperties.append(create(attribute: "lfCoreDataEntityGroupIdentifier", type: .stringAttributeType, isOptional: true))
        selfReferencedClassDescription.properties = selfReferencedClassProperties

        // Service.serviceIdAttribute Attribute
        serviceProperties.append(create(attribute: "id", type: attributeType(for: "id", ofType: String.self), isOptional: false))

        // Service.serviceInfoAttribute Attribute
        serviceProperties.append(create(attribute: "info", type: attributeType(for: "info", ofType: String.self), isOptional: false))

        // Service.serviceTypeAttribute Attribute
        serviceProperties.append(create(attribute: "type", type: attributeType(for: "type", ofType: String.self), isOptional: false))
        serviceProperties.append(create(attribute: "lfCoreDataEntityIsPopulated", type: .booleanAttributeType, isOptional: false, defaultValue: false))
        serviceProperties.append(create(attribute: "lfCoreDataEntityGroupIdentifier", type: .stringAttributeType, isOptional: true))
        serviceDescription.properties = serviceProperties

        // Structs.structsIdAttribute Attribute
        structsProperties.append(create(attribute: "id", type: attributeType(for: "id", ofType: String.self), isOptional: false))

        // Structs.structsNameAttribute Attribute
        structsProperties.append(create(attribute: "name", type: attributeType(for: "name", ofType: String.self), isOptional: false))
        structsProperties.append(create(attribute: "lfCoreDataEntityIsPopulated", type: .booleanAttributeType, isOptional: false, defaultValue: false))
        structsProperties.append(create(attribute: "lfCoreDataEntityGroupIdentifier", type: .stringAttributeType, isOptional: true))
        structsDescription.properties = structsProperties

        // Work.workIdAttribute Attribute
        workProperties.append(create(attribute: "id", type: attributeType(for: "id", ofType: String?.self), isOptional: true))

        // Work.workNameAttribute Attribute
        workProperties.append(create(attribute: "name", type: attributeType(for: "name", ofType: String.self), isOptional: false))
        workProperties.append(create(attribute: "lfCoreDataEntityIsPopulated", type: .booleanAttributeType, isOptional: false, defaultValue: false))
        workProperties.append(create(attribute: "lfCoreDataEntityGroupIdentifier", type: .stringAttributeType, isOptional: true))
        workDescription.properties = workProperties
        // ManagedChildRecursiveClass -> ManagedGrandchildRecursiveClass Relationship
        childRecursiveClassGrandchildRelationship.populate(with: "grandchild", destination: coreDataStore_v100.entityDescription(for: "ManagedGrandchildRecursiveClass"), isArray: false, deleteRule: .cascadeDeleteRule, inverseRelationship: childRecursiveClassInverseGrandchildRelationship)
        coreDataStore_v100.entityDescription(for: "ManagedChildRecursiveClass").properties.append(childRecursiveClassGrandchildRelationship)

        // ManagedChildRecursiveClass -> ManagedGrandchildRecursiveClass Inverse Relationship
        childRecursiveClassInverseGrandchildRelationship.populate(with: "childRecursiveClassInverseGrandchildRelationship", destination: coreDataStore_v100.entityDescription(for: "ManagedChildRecursiveClass"), isArray: false, deleteRule: .cascadeDeleteRule, inverseRelationship: childRecursiveClassGrandchildRelationship)
        coreDataStore_v100.entityDescription(for: "ManagedGrandchildRecursiveClass").properties.append(childRecursiveClassInverseGrandchildRelationship)

        // ManagedChildRecursiveClass -> ManagedParentRecursiveClass Relationship
        childRecursiveClassParentRelationship.populate(with: "parent", destination: coreDataStore_v100.entityDescription(for: "ManagedParentRecursiveClass"), isArray: false, deleteRule: .cascadeDeleteRule, inverseRelationship: childRecursiveClassInverseParentRelationship)
        coreDataStore_v100.entityDescription(for: "ManagedChildRecursiveClass").properties.append(childRecursiveClassParentRelationship)

        // ManagedChildRecursiveClass -> ManagedParentRecursiveClass Inverse Relationship
        childRecursiveClassInverseParentRelationship.populate(with: "childRecursiveClassInverseParentRelationship", destination: coreDataStore_v100.entityDescription(for: "ManagedChildRecursiveClass"), isArray: false, deleteRule: .cascadeDeleteRule, inverseRelationship: childRecursiveClassParentRelationship)
        coreDataStore_v100.entityDescription(for: "ManagedParentRecursiveClass").properties.append(childRecursiveClassInverseParentRelationship)

        // ManagedChildStruct -> ManagedGrandChild Relationship
        childStructChildRelationship.populate(with: "child", destination: coreDataStore_v100.entityDescription(for: "ManagedGrandChild"), isArray: false, deleteRule: .cascadeDeleteRule, inverseRelationship: childStructInverseChildRelationship)
        coreDataStore_v100.entityDescription(for: "ManagedChildStruct").properties.append(childStructChildRelationship)

        // ManagedChildStruct -> ManagedGrandChild Inverse Relationship
        childStructInverseChildRelationship.populate(with: "childStructInverseChildRelationship", destination: coreDataStore_v100.entityDescription(for: "ManagedChildStruct"), isArray: false, deleteRule: .cascadeDeleteRule, inverseRelationship: childStructChildRelationship)
        coreDataStore_v100.entityDescription(for: "ManagedGrandChild").properties.append(childStructInverseChildRelationship)

        // ManagedChildStruct -> ManagedProject Relationship
        childStructProjectsRelationship.populate(with: "projects", destination: coreDataStore_v100.entityDescription(for: "ManagedProject"), isArray: true, deleteRule: .cascadeDeleteRule, inverseRelationship: childStructInverseProjectsRelationship)
        coreDataStore_v100.entityDescription(for: "ManagedChildStruct").properties.append(childStructProjectsRelationship)

        // ManagedChildStruct -> ManagedProject Inverse Relationship
        childStructInverseProjectsRelationship.populate(with: "childStructInverseProjectsRelationship", destination: coreDataStore_v100.entityDescription(for: "ManagedChildStruct"), isArray: true, deleteRule: .cascadeDeleteRule, inverseRelationship: childStructProjectsRelationship)
        coreDataStore_v100.entityDescription(for: "ManagedProject").properties.append(childStructInverseProjectsRelationship)

        // ManagedGrandchildRecursiveClass -> ManagedParentRecursiveClass Relationship
        grandchildRecursiveClassGrandfatherRelationship.populate(with: "grandfather", destination: coreDataStore_v100.entityDescription(for: "ManagedParentRecursiveClass"), isArray: false, deleteRule: .cascadeDeleteRule, inverseRelationship: grandchildRecursiveClassInverseGrandfatherRelationship)
        coreDataStore_v100.entityDescription(for: "ManagedGrandchildRecursiveClass").properties.append(grandchildRecursiveClassGrandfatherRelationship)

        // ManagedGrandchildRecursiveClass -> ManagedParentRecursiveClass Inverse Relationship
        grandchildRecursiveClassInverseGrandfatherRelationship.populate(with: "grandchildRecursiveClassInverseGrandfatherRelationship", destination: coreDataStore_v100.entityDescription(for: "ManagedGrandchildRecursiveClass"), isArray: false, deleteRule: .cascadeDeleteRule, inverseRelationship: grandchildRecursiveClassGrandfatherRelationship)
        coreDataStore_v100.entityDescription(for: "ManagedParentRecursiveClass").properties.append(grandchildRecursiveClassInverseGrandfatherRelationship)

        // ManagedMainEntity -> ManagedNestedEntity Relationship
        mainEntityNestedFieldRelationship.populate(with: "nestedField", destination: coreDataStore_v100.entityDescription(for: "ManagedNestedEntity"), isArray: false, deleteRule: .cascadeDeleteRule, inverseRelationship: mainEntityInverseNestedFieldRelationship)
        coreDataStore_v100.entityDescription(for: "ManagedMainEntity").properties.append(mainEntityNestedFieldRelationship)

        // ManagedMainEntity -> ManagedNestedEntity Inverse Relationship
        mainEntityInverseNestedFieldRelationship.populate(with: "mainEntityInverseNestedFieldRelationship", destination: coreDataStore_v100.entityDescription(for: "ManagedMainEntity"), isArray: false, deleteRule: .cascadeDeleteRule, inverseRelationship: mainEntityNestedFieldRelationship)
        coreDataStore_v100.entityDescription(for: "ManagedNestedEntity").properties.append(mainEntityInverseNestedFieldRelationship)

        // ManagedParentNestedClass -> ManagedChildNestedClass Relationship
        parentNestedClassChildRelationship.populate(with: "child", destination: coreDataStore_v100.entityDescription(for: "ManagedChildNestedClass"), isArray: false, deleteRule: .cascadeDeleteRule, inverseRelationship: parentNestedClassInverseChildRelationship)
        coreDataStore_v100.entityDescription(for: "ManagedParentNestedClass").properties.append(parentNestedClassChildRelationship)

        // ManagedParentNestedClass -> ManagedChildNestedClass Inverse Relationship
        parentNestedClassInverseChildRelationship.populate(with: "parentNestedClassInverseChildRelationship", destination: coreDataStore_v100.entityDescription(for: "ManagedParentNestedClass"), isArray: false, deleteRule: .cascadeDeleteRule, inverseRelationship: parentNestedClassChildRelationship)
        coreDataStore_v100.entityDescription(for: "ManagedChildNestedClass").properties.append(parentNestedClassInverseChildRelationship)

        // ManagedParentRecursiveClass -> ManagedChildRecursiveClass Relationship
        parentRecursiveClassChildRelationship.populate(with: "child", destination: coreDataStore_v100.entityDescription(for: "ManagedChildRecursiveClass"), isArray: false, deleteRule: .cascadeDeleteRule, inverseRelationship: parentRecursiveClassInverseChildRelationship)
        coreDataStore_v100.entityDescription(for: "ManagedParentRecursiveClass").properties.append(parentRecursiveClassChildRelationship)

        // ManagedParentRecursiveClass -> ManagedChildRecursiveClass Inverse Relationship
        parentRecursiveClassInverseChildRelationship.populate(with: "parentRecursiveClassInverseChildRelationship", destination: coreDataStore_v100.entityDescription(for: "ManagedParentRecursiveClass"), isArray: false, deleteRule: .cascadeDeleteRule, inverseRelationship: parentRecursiveClassChildRelationship)
        coreDataStore_v100.entityDescription(for: "ManagedChildRecursiveClass").properties.append(parentRecursiveClassInverseChildRelationship)

        // ManagedParentStruct -> ManagedChildStruct Relationship
        parentStructChildRelationship.populate(with: "child", destination: coreDataStore_v100.entityDescription(for: "ManagedChildStruct"), isArray: false, deleteRule: .cascadeDeleteRule, inverseRelationship: parentStructInverseChildRelationship)
        coreDataStore_v100.entityDescription(for: "ManagedParentStruct").properties.append(parentStructChildRelationship)

        // ManagedParentStruct -> ManagedChildStruct Inverse Relationship
        parentStructInverseChildRelationship.populate(with: "parentStructInverseChildRelationship", destination: coreDataStore_v100.entityDescription(for: "ManagedParentStruct"), isArray: false, deleteRule: .cascadeDeleteRule, inverseRelationship: parentStructChildRelationship)
        coreDataStore_v100.entityDescription(for: "ManagedChildStruct").properties.append(parentStructInverseChildRelationship)

        // ManagedPerson -> ManagedWork Relationship
        workingActivityWorkArrayAtRelationship.populate(with: "workingActivityWorkArrayAt", destination: coreDataStore_v100.entityDescription(for: "ManagedWork"), isArray: true, deleteRule: .nullifyDeleteRule, inverseRelationship: inverseWorkingActivityWorkArrayRelationship)
        coreDataStore_v100.entityDescription(for: "ManagedPerson").properties.append(workingActivityWorkArrayAtRelationship)

        // ManagedPerson -> ManagedWork Inverse Relationship
        inverseWorkingActivityWorkArrayRelationship.populate(with: "inverseWorkingActivityWorkArray", destination: coreDataStore_v100.entityDescription(for: "ManagedPerson"), isArray: true, deleteRule: .nullifyDeleteRule, inverseRelationship: workingActivityWorkArrayAtRelationship)
        coreDataStore_v100.entityDescription(for: "ManagedWork").properties.append(inverseWorkingActivityWorkArrayRelationship)
        // ManagedPerson -> ManagedCar Relationship
        drivingActivityCarVehicleRelationship.populate(with: "drivingActivityCarVehicle", destination: coreDataStore_v100.entityDescription(for: "ManagedCar"), isArray: false, deleteRule: .nullifyDeleteRule, inverseRelationship: inverseDrivingActivityCarRelationship)
        coreDataStore_v100.entityDescription(for: "ManagedPerson").properties.append(drivingActivityCarVehicleRelationship)

        // ManagedPerson -> ManagedActivity Relationship
        inverseDrivingActivityCarRelationship.populate(with: "inverseDrivingActivityCar", destination: coreDataStore_v100.entityDescription(for: "ManagedPerson"), isArray: false, deleteRule: .nullifyDeleteRule, inverseRelationship: drivingActivityCarVehicleRelationship)
        coreDataStore_v100.entityDescription(for: "ManagedCar").properties.append(inverseDrivingActivityCarRelationship)
        // ManagedPerson -> ManagedAirplane Relationship
        flyingActivityAirplaneVehicleRelationship.populate(with: "flyingActivityAirplaneVehicle", destination: coreDataStore_v100.entityDescription(for: "ManagedAirplane"), isArray: false, deleteRule: .nullifyDeleteRule, inverseRelationship: inverseFlyingActivityAirplaneRelationship)
        coreDataStore_v100.entityDescription(for: "ManagedPerson").properties.append(flyingActivityAirplaneVehicleRelationship)

        // ManagedPerson -> ManagedActivity Relationship
        inverseFlyingActivityAirplaneRelationship.populate(with: "inverseFlyingActivityAirplane", destination: coreDataStore_v100.entityDescription(for: "ManagedPerson"), isArray: false, deleteRule: .nullifyDeleteRule, inverseRelationship: flyingActivityAirplaneVehicleRelationship)
        coreDataStore_v100.entityDescription(for: "ManagedAirplane").properties.append(inverseFlyingActivityAirplaneRelationship)
        // ManagedProduct -> ManagedService Relationship
        productServicesRelationship.populate(with: "services", destination: coreDataStore_v100.entityDescription(for: "ManagedService"), isArray: true, deleteRule: .cascadeDeleteRule, inverseRelationship: productInverseServicesRelationship)
        coreDataStore_v100.entityDescription(for: "ManagedProduct").properties.append(productServicesRelationship)

        // ManagedProduct -> ManagedService Inverse Relationship
        productInverseServicesRelationship.populate(with: "productInverseServicesRelationship", destination: coreDataStore_v100.entityDescription(for: "ManagedProduct"), isArray: true, deleteRule: .cascadeDeleteRule, inverseRelationship: productServicesRelationship)
        coreDataStore_v100.entityDescription(for: "ManagedService").properties.append(productInverseServicesRelationship)

        // ManagedSelfReferencedClass -> ManagedSelfReferencedClass Relationship
        selfReferencedClassChildRelationship.populate(with: "child", destination: coreDataStore_v100.entityDescription(for: "ManagedSelfReferencedClass"), isArray: false, deleteRule: .cascadeDeleteRule, inverseRelationship: selfReferencedClassInverseChildRelationship)
        coreDataStore_v100.entityDescription(for: "ManagedSelfReferencedClass").properties.append(selfReferencedClassChildRelationship)

        // ManagedSelfReferencedClass -> ManagedSelfReferencedClass Inverse Relationship
        selfReferencedClassInverseChildRelationship.populate(with: "selfReferencedClassInverseChildRelationship", destination: coreDataStore_v100.entityDescription(for: "ManagedSelfReferencedClass"), isArray: false, deleteRule: .cascadeDeleteRule, inverseRelationship: selfReferencedClassChildRelationship)
        coreDataStore_v100.entityDescription(for: "ManagedSelfReferencedClass").properties.append(selfReferencedClassInverseChildRelationship)

    }
}
