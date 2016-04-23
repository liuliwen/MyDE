function bestval = Copy_of_runcompe(fname, fun, D, NP, Max_Gen, runindex, fid)

switch fun
        case 1
            % lu: define the upper and lower bounds of the variables
            lu = [-100 * ones(1, D); 100 * ones(1, D)];
            % Load the data for this test function
            load sphere_func_data
        case 2
            lu = [-100 * ones(1, D); 100 * ones(1, D)];
            load schwefel_102_data
        case 3

            lu = [-100 * ones(1, D); 100 * ones(1, D)];
            load high_cond_elliptic_rot_data
            if D == 2, load elliptic_M_D2,
            elseif D == 10, load elliptic_M_D10,
            elseif D == 30, load elliptic_M_D30,
            elseif D == 50, load elliptic_M_D50,
            end
        case 4
            lu = [-100 * ones(1, D); 100 * ones(1, D)];
            load schwefel_102_data
        case 5
            lu = [-100 * ones(1, D); 100 * ones(1, D)];
            load schwefel_206_data
        case 6
            lu = [-100 * ones(1, D); 100 * ones(1, D)];
            load rosenbrock_func_data
        case 7
            lu = [0 * ones(1, D); 600 * ones(1, D)];
            load griewank_func_data
            if D == 2, load griewank_M_D2,
            elseif D == 10, load griewank_M_D10,
            elseif D == 30, load griewank_M_D30,
            elseif D == 50, load griewank_M_D50,
            end
        case 8

            lu = [-32 * ones(1, D); 32 * ones(1, D)];
            load ackley_func_data
            if D == 2, load ackley_M_D2,
            elseif D == 10, load ackley_M_D10,
            elseif D == 30, load ackley_M_D30,
            elseif D == 50, load ackley_M_D50,
            end
        case 9

            lu = [-5 * ones(1, D); 5 * ones(1, D)];
            load rastrigin_func_data
        case 10

            lu = [-5 * ones(1, D); 5 * ones(1, D)];
            load rastrigin_func_data
            if D == 2, load rastrigin_M_D2,
            elseif D == 10, load rastrigin_M_D10,
            elseif D == 30, load rastrigin_M_D30,
            elseif D == 50, load rastrigin_M_D50,
            end

        case 11

            lu = [-0.5 * ones(1, D); 0.5 * ones(1, D)];
            load weierstrass_data
            if D == 2, load weierstrass_M_D2, ,
            elseif D == 10, load weierstrass_M_D10,
            elseif D == 30, load weierstrass_M_D30,
            elseif D == 50, load weierstrass_M_D50,
            end

        case 12

            lu = [-pi * ones(1, D); pi * ones(1, D)];
            load schwefel_213_data 
        case 13

            lu = [-3 * ones(1, D); 1 * ones(1, D)];
            load EF8F2_func_data
             

        case 14

            lu = [-100 * ones(1, D); 100 * ones(1, D)];
            load E_ScafferF6_func_data
            if D == 2, load E_ScafferF6_M_D2, ,
            elseif D == 10, load E_ScafferF6_M_D10,
            elseif D == 30, load E_ScafferF6_M_D30,
            elseif D == 50, load E_ScafferF6_M_D50,
            end
             

        case 15

            lu = [-5 * ones(1, D); 5 * ones(1, D)];
            load hybrid_func1_data
             

        case 16

            lu = [-5 * ones(1, D); 5 * ones(1, D)];
            load hybrid_func1_data
            if D == 2, load hybrid_func1_M_D2,
            elseif D == 10, load hybrid_func1_M_D10,
            elseif D == 30, load hybrid_func1_M_D30,
            elseif D == 50, load hybrid_func1_M_D50,
            end
             

        case 17

            lu = [-5 * ones(1, D); 5 * ones(1, D)];
            load hybrid_func1_data
            if D == 2, load hybrid_func1_M_D2,
            elseif D == 10, load hybrid_func1_M_D10,
            elseif D == 30, load hybrid_func1_M_D30,
            elseif D == 50, load hybrid_func1_M_D50,
            end
             

        case 18

            lu = [-5 * ones(1, D); 5 * ones(1, D)];
            load hybrid_func2_data
            if D == 2, load hybrid_func2_M_D2,
            elseif D == 10, load hybrid_func2_M_D10,
            elseif D == 30, load hybrid_func2_M_D30,
            elseif D == 50, load hybrid_func2_M_D50,
            end
             

        case 19

            lu = [-5 * ones(1, D); 5 * ones(1, D)];
            load hybrid_func2_data
            if D == 2, load hybrid_func2_M_D2,
            elseif D == 10, load hybrid_func2_M_D10,
            elseif D == 30, load hybrid_func2_M_D30,
            elseif D == 50, load hybrid_func2_M_D50,
            end
             

        case 20

            lu = [-5 * ones(1, D); 5 * ones(1, D)];
            load hybrid_func2_data
            if D == 2, load hybrid_func2_M_D2,
            elseif D == 10, load hybrid_func2_M_D10,
            elseif D == 30, load hybrid_func2_M_D30,
            elseif D == 50, load hybrid_func2_M_D50,
            end
             

        case 21

            lu = [-5 * ones(1, D); 5 * ones(1, D)];
            load hybrid_func3_data
            if D == 2, load hybrid_func3_M_D2,
            elseif D == 10, load hybrid_func3_M_D10,
            elseif D == 30, load hybrid_func3_M_D30,
            elseif D == 50, load hybrid_func3_M_D50,
            end
             

        case 22

            lu = [-5 * ones(1, D); 5 * ones(1, D)];
            load hybrid_func3_data
            if D == 2, load hybrid_func3_HM_D2,
            elseif D == 10, load hybrid_func3_HM_D10,
            elseif D == 30, load hybrid_func3_HM_D30,
            elseif D == 50, load hybrid_func3_HM_D50,
            end
             

        case 23

            lu = [-5 * ones(1, D); 5 * ones(1, D)];
            load hybrid_func3_data
            if D == 2, load hybrid_func3_M_D2,
            elseif D == 10, load hybrid_func3_M_D10,
            elseif D == 30, load hybrid_func3_M_D30,
            elseif D == 50, load hybrid_func3_M_D50,
            end
             

        case 24

            lu = [-5 * ones(1, D); 5 * ones(1, D)];
            load hybrid_func4_data
            if D == 2, load hybrid_func4_M_D2,
            elseif D == 10, load hybrid_func4_M_D10,
            elseif D == 30, load hybrid_func4_M_D30,
            elseif D == 50, load hybrid_func4_M_D50,
            end
             

        case 25

            lu = [2 * ones(1, D); 5 * ones(1, D)];
            load hybrid_func4_data
            if D == 2, load hybrid_func4_M_D2,
            elseif D == 10, load hybrid_func4_M_D10,
            elseif D == 30, load hybrid_func4_M_D30,
            elseif D == 50, load hybrid_func4_M_D50,
            end
             
end
%Ubound=lu(2,:);
%pop = repmat(Lbound,NP,1) + rand(NP, D) .* repmat(Ubound-Lbound,NP,1);
%bestval=feval(fname,pop,fun);
bestval = DECRC_SelectFromTwo(fname, fun, D, repmat(lu(1,:),NP,1), repmat(lu(2,:),NP,1), NP, Max_Gen, runindex, fid);
% bestval = SaDEGL(fname, fun, D, repmat(lu(1,:),NP,1), repmat(lu(2,:),NP,1), NP, Max_Gen, runindex, fid);
%bestval = sansde(fname, fun, D, lu(1,:), lu(2,:), NP, Max_Gen, runindex, fid);

