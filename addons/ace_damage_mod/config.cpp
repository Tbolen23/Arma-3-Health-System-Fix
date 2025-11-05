class CfgPatches {
    class ace_damage_mod {
        name = "ACE Damage Modifier";
        author = "Custom";
        url = "";
        units[] = {};
        weapons[] = {};
        requiredVersion = 1.0;
        requiredAddons[] = {"ace_medical", "ace_medical_damage"};
        version = "1.0.0";
        versionStr = "1.0.0";
        versionAr[] = {1,0,0};
    };
};

class CfgFunctions {
    class ace_damage_mod {
        tag = "ace_dmg";
        class functions {
            file = "\addons\ace_damage_mod\functions";
            class init {
                postInit = 1;
            };
            class handleDamage {};
            class handleExplosion {};
        };
    };
};
