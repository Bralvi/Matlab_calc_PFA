classdef Photon
    %PHOTON Summary of this class goes here
    %   Detailed explanation goes here

    properties
        status = ''
    end
    properties 
        lambda = NaN; % [nm]
        coordinates = [0, 0, 0] % Coordinates x, y, z
        direction = [0, 0]      % Direction \sigma, \phi
        coordinate_history = [];
        lifetime = 0;
        
    end
    
    methods
        function obj = Photon(varargin)
            % Initiation of photon characteristics
            % x, y, z, sigma, phi, lambda
            % x, y, z, sigma, phi
            % x, y, sigma, lambda
            % x, y, sigma
            switch nargin()
                case 3
                    obj.coordinates = [varargin{1}, varargin{2}, 0];
                    obj.direction = [varargin{3}, 0];
                case 4
                    obj.coordinates = [varargin{1}, varargin{2}, 0];
                    obj.direction = [varargin{3}, 0];
                    obj.lambda = varargin{4};
                case 5
                    obj.coordinates = [varargin{1}, varargin{2}, varargin{3}];
                    obj.direction = [varargin{4}, varargin{5}];
                case 6
                    obj.coordinates = [varargin{1}, varargin{2}, varargin{3}];
                    obj.direction = [varargin{4}, varargin{5}];
                    obj.lambda = varargin{6};
                otherwise
                    error('Invalid number of input parameters');
            end
            obj.coordinate_history = [obj.coordinates 0];
        end
        
        
        function obj = change_coordinates(obj,varargin)
            % Изменяем координаты и направления фотона 
            % (x, y, z, sigma, phi, n)
            % (x, y, sigma, n) 

            LightSpeed = 299792458000; % [mm/s]
            old_coordinates = obj.coordinates;
            if numel(varargin) == 4
                obj.coordinates = [varargin{1}, varargin{2}, 0];
                obj.direction = [varargin{3}, 0];
                n = varargin{4};
            elseif numel(varargin) == 6
                obj.coordinates = [varargin{1}, varargin{2}, varargin{3}];
                obj.direction = [varargin{4}, varargin{5}];
                n = varargin{6};
            else
                error('Invalid number of input parameters');
            end
            dt = sqrt(sum((old_coordinates - obj.coordinates).^2)).*n ./  LightSpeed;
            obj.coordinate_history = [obj.coordinate_history; [obj.coordinates dt]];
        end
        
        function out_arg = get_coordinates(obj) 
            % Returning the coordinates of the photon
            out_arg = obj.coordinates;
        end
        
        function out_arg = get_direction(obj)
            % Выводим координаты
            out_arg = obj.coordinates;
        end         
  
        function obj = set_lambda(obj,lambda)
            % Задаем длину волны
            obj.lambda = lambda;
        end

        function out_arg = get_lambda(obj)
            % Выводим координаты
            out_arg = obj.lambda;
        end           
    end
end

