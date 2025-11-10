class CfgPatches {
    class ace_damage_mod {
        name = "ACE Damage Modifier";
        author = "Tbolen23";
        url = "";
        units[] = {};
        weapons[] = {};
        requiredVersion = 1.0;
        requiredAddons[] = {"ace_medical", "ace_medical_damage"};
        version = "2.0.1";
        versionStr = "2.0.1";
        versionAr[] = {2,0,1};
    };
};

class CfgFunctions {
    class ace_damage_mod {
        tag = "ace_dmg";
        class functions {
            file = "\z\ace_dmg\addons\ace_damage_mod\functions";
            class init {
                postInit = 1;
            };
            class handleDamage {};
            class handleExplosion {};
        };
    };
};
