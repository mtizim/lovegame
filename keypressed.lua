-- handle the buttons being pressed

function love.keypressed(key)
    -- no other presses on an android
    if key == "escape" then escape_pressed() end
    if key == "power" then power_pressed() end
end

function escape_pressed()
    if application.current:instanceOf(gameClass) then
        if application.current.player.alive then
            application.current:pause()
        else
            go_to_menu()
        end
    end
    if application.current:instanceOf(main_menuClass) and
        application.current.settings_bool then
            application.current:revert_settings()
    end

end

function power_pressed()
    if application.current:instanceOf(gameClass) then
        application.current:pause()
    end
end